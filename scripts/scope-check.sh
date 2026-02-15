#!/usr/bin/env bash
# PreToolUse hook: Validate Write/Edit targets stay within project or ~/.claude/
# Exit 0 = approve, Exit 2 = deny

INPUT=$(cat)

TOOL_NAME=$(echo "$INPUT" | grep -oP '"tool_name"\s*:\s*"[^"]*"' | head -1 | sed 's/.*":\s*"//' | sed 's/"$//')

# Only check Write and Edit tools
if [ "$TOOL_NAME" != "Write" ] && [ "$TOOL_NAME" != "Edit" ]; then
  exit 0
fi

# Extract file_path (exit-code based fallback for Windows)
if FILE_PATH=$(echo "$INPUT" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('tool_input',{}).get('file_path',''))" 2>/dev/null); then
  :
elif FILE_PATH=$(echo "$INPUT" | python -c "import sys,json; d=json.load(sys.stdin); print(d.get('tool_input',{}).get('file_path',''))" 2>/dev/null); then
  :
else
  FILE_PATH=$(echo "$INPUT" | grep -oP '"file_path"\s*:\s*"[^"]*"' | head -1 | sed 's/.*":\s*"//' | sed 's/"$//')
fi

# Normalize path (convert backslash to forward slash for comparison)
FILE_PATH=$(echo "$FILE_PATH" | sed 's|\\|/|g')

# Allow writes to ~/.claude/ (agent/skill/knowledge management)
HOME_NORMALIZED=$(echo "$HOME" | sed 's|\\|/|g')
if echo "$FILE_PATH" | grep -qi "${HOME_NORMALIZED}/.claude/"; then
  exit 0
fi
if echo "$FILE_PATH" | grep -qiE '(\.claude/|/Users/[^/]+/\.claude/)'; then
  exit 0
fi

# Allow writes within CLAUDE_PROJECT_DIR if set
if [ -n "$CLAUDE_PROJECT_DIR" ]; then
  PROJECT_DIR=$(echo "$CLAUDE_PROJECT_DIR" | sed 's|\\|/|g')
  if echo "$FILE_PATH" | grep -qi "$PROJECT_DIR"; then
    exit 0
  fi
fi

# Allow writes to common project paths (cross-platform)
if echo "$FILE_PATH" | grep -qiE '^(/[a-z]/[Pp]rojects/|/home/[^/]+/projects/|/Users/[^/]+/[Pp]rojects/|[A-Z]:/[Pp]rojects/)'; then
  exit 0
fi

# Allow writes to /tmp/ and temp directories
if echo "$FILE_PATH" | grep -qiE '^(/tmp/|/var/tmp/|.*/[Tt]emp/)'; then
  exit 0
fi

# Block writes to system directories
if echo "$FILE_PATH" | grep -qiE '^(/(etc|usr|bin|sbin|var|boot)|/[a-z]/(Windows|Program))'; then
  echo '{"error":"BLOCKED: Write to system directory"}' >&2
  exit 2
fi

# Default: approve (trust the agent)
exit 0
