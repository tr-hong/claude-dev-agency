#!/usr/bin/env bash
# PreToolUse hook: Block dangerous Bash commands
# Exit 0 = approve, Exit 2 = deny
# Receives JSON on stdin: {"tool_name":"Bash","tool_input":{"command":"..."}}

INPUT=$(cat)

# Try python3, then python, then basic grep (exit-code based fallback for Windows)
parse_json() {
  local field="$1"
  local result=""
  if result=$(echo "$INPUT" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('tool_input',{}).get('$field',''))" 2>/dev/null); then
    echo "$result"
  elif result=$(echo "$INPUT" | python -c "import sys,json; d=json.load(sys.stdin); print(d.get('tool_input',{}).get('$field',''))" 2>/dev/null); then
    echo "$result"
  else
    echo "$INPUT" | grep -oP "\"$field\"\s*:\s*\"[^\"]*\"" | head -1 | sed 's/.*":\s*"//' | sed 's/"$//'
  fi
}

TOOL_NAME=$(echo "$INPUT" | grep -oP '"tool_name"\s*:\s*"[^"]*"' | head -1 | sed 's/.*":\s*"//' | sed 's/"$//')

if [ "$TOOL_NAME" = "Bash" ]; then
  COMMAND=$(parse_json "command")

  # Block rm -rf on root, home, or system paths
  if echo "$COMMAND" | grep -qiE 'rm\s+(-[a-zA-Z]*f[a-zA-Z]*\s+|--force\s+)*(\/|\/\*|~\/?\*?|~|\$HOME)(\s|$)'; then
    echo '{"error":"BLOCKED: Destructive rm on root/home path"}' >&2
    exit 2
  fi

  # Block sudo rm with force flags
  if echo "$COMMAND" | grep -qiE 'sudo\s+rm\s+(-[a-zA-Z]*f|--force)'; then
    echo '{"error":"BLOCKED: sudo rm with force flag"}' >&2
    exit 2
  fi

  # Block chmod -R 777 on root
  if echo "$COMMAND" | grep -qiE 'chmod\s+(-R\s+)?777\s+\/'; then
    echo '{"error":"BLOCKED: chmod 777 on system path"}' >&2
    exit 2
  fi

  # Block fork bomb
  if echo "$COMMAND" | grep -qF ':(){ :|:& };:'; then
    echo '{"error":"BLOCKED: Fork bomb detected"}' >&2
    exit 2
  fi

  # Block mkfs and dd to devices
  if echo "$COMMAND" | grep -qiE '(mkfs\.|dd\s+.*of=\/dev\/)'; then
    echo '{"error":"BLOCKED: Filesystem/device destructive command"}' >&2
    exit 2
  fi

  # Block force push to main/master
  if echo "$COMMAND" | grep -qiE 'git\s+push\s+.*--force.*(main|master)'; then
    echo '{"error":"BLOCKED: Force push to main/master"}' >&2
    exit 2
  fi

  # Block staging .env files
  if echo "$COMMAND" | grep -qiE 'git\s+add\s+.*\.env(\s|$)'; then
    echo '{"error":"BLOCKED: Staging .env file"}' >&2
    exit 2
  fi
fi

exit 0
