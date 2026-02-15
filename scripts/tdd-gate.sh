#!/usr/bin/env bash
# PostToolUse hook: TDD reminder when production code is modified
# Does NOT block (always exit 0), just outputs a reminder

INPUT=$(cat)

TOOL_NAME=$(echo "$INPUT" | grep -oP '"tool_name"\s*:\s*"[^"]*"' | head -1 | sed 's/.*":\s*"//' | sed 's/"$//')

# Only check Write and Edit
if [ "$TOOL_NAME" != "Write" ] && [ "$TOOL_NAME" != "Edit" ]; then
  exit 0
fi

# Extract file_path (exit-code based fallback for Windows)
if FILE_PATH=$(echo "$INPUT" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('tool_input',{}).get('file_path',''))" 2>/dev/null); then
  :
elif FILE_PATH=$(echo "$INPUT" | python -c "import sys,json; d=json.load(sys.stdin); print(d.get('tool_input',{}).get('file_path',''))" 2>/dev/null); then
  :
else
  FILE_PATH=""
fi

# Skip if file path not detected
[ -z "$FILE_PATH" ] && exit 0

# Skip test files, config files, type definitions
if echo "$FILE_PATH" | grep -qiE '\.(test|spec|stories)\.(ts|tsx|js|jsx)$'; then
  exit 0
fi
if echo "$FILE_PATH" | grep -qiE '(config|\.d\.ts|types\.ts|\.json|\.md|\.css|\.html)$'; then
  exit 0
fi
if echo "$FILE_PATH" | grep -qiE '(__tests__|__mocks__|fixtures|golden)'; then
  exit 0
fi

# Production code detected
if echo "$FILE_PATH" | grep -qiE '\.(ts|tsx|js|jsx|py)$'; then
  echo "[TDD] Production code modified: $(basename "$FILE_PATH"). Ensure a test covers this change."
fi

exit 0
