#!/usr/bin/env bash
# SessionStart hook: Ensure knowledge directory structure exists
# Idempotent — safe to run multiple times
# Compatible with Windows (Git Bash), macOS, Linux

KNOWLEDGE_DIR="$HOME/.claude/knowledge"
ADOPTED_DIR="$HOME/.claude/skills/adopted"

# Resolve PLUGIN_ROOT with Windows-safe fallback
if [ -n "$CLAUDE_PLUGIN_ROOT" ]; then
  PLUGIN_ROOT="$CLAUDE_PLUGIN_ROOT"
else
  # $0 may contain Windows-style paths (C:\...\scripts\init-knowledge.sh)
  # Convert backslashes to forward slashes before dirname
  SCRIPT_PATH="${0//\\//}"
  SCRIPT_DIR="$(cd "$(dirname "$SCRIPT_PATH")" 2>/dev/null && pwd)" || SCRIPT_DIR=""
  if [ -n "$SCRIPT_DIR" ]; then
    PLUGIN_ROOT="$(cd "$SCRIPT_DIR/.." 2>/dev/null && pwd)" || PLUGIN_ROOT=""
  else
    PLUGIN_ROOT=""
  fi
fi

# Create knowledge directories
mkdir -p "$KNOWLEDGE_DIR/entries" 2>/dev/null || true
mkdir -p "$KNOWLEDGE_DIR/resources" 2>/dev/null || true
mkdir -p "$KNOWLEDGE_DIR/reports" 2>/dev/null || true
mkdir -p "$KNOWLEDGE_DIR/diagrams/good-examples" 2>/dev/null || true
mkdir -p "$KNOWLEDGE_DIR/diagrams/templates" 2>/dev/null || true
mkdir -p "$ADOPTED_DIR" 2>/dev/null || true

# Initialize template files if they don't exist (only if PLUGIN_ROOT is resolved)
if [ -n "$PLUGIN_ROOT" ]; then
  [ ! -f "$KNOWLEDGE_DIR/_catalog.md" ] && cp "$PLUGIN_ROOT/templates/knowledge/_catalog.md" "$KNOWLEDGE_DIR/_catalog.md" 2>/dev/null || true
  [ ! -f "$KNOWLEDGE_DIR/resources/_processed.md" ] && cp "$PLUGIN_ROOT/templates/knowledge/resources/_processed.md" "$KNOWLEDGE_DIR/resources/_processed.md" 2>/dev/null || true
  [ ! -f "$KNOWLEDGE_DIR/reports/_latest.md" ] && cp "$PLUGIN_ROOT/templates/knowledge/reports/_latest.md" "$KNOWLEDGE_DIR/reports/_latest.md" 2>/dev/null || true
  [ ! -f "$ADOPTED_DIR/_registry.md" ] && cp "$PLUGIN_ROOT/templates/adopted/_registry.md" "$ADOPTED_DIR/_registry.md" 2>/dev/null || true
fi

exit 0
