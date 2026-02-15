#!/usr/bin/env bash
# SessionStart hook: Ensure knowledge directory structure exists
# Idempotent — safe to run multiple times

KNOWLEDGE_DIR="$HOME/.claude/knowledge"
ADOPTED_DIR="$HOME/.claude/skills/adopted"
PLUGIN_ROOT="${CLAUDE_PLUGIN_ROOT:-$(cd "$(dirname "$0")/.." && pwd)}"

# Create knowledge directories
mkdir -p "$KNOWLEDGE_DIR/entries"
mkdir -p "$KNOWLEDGE_DIR/resources"
mkdir -p "$KNOWLEDGE_DIR/reports"
mkdir -p "$KNOWLEDGE_DIR/diagrams/good-examples"
mkdir -p "$KNOWLEDGE_DIR/diagrams/templates"
mkdir -p "$ADOPTED_DIR"

# Initialize template files if they don't exist
[ ! -f "$KNOWLEDGE_DIR/_catalog.md" ] && cp "$PLUGIN_ROOT/templates/knowledge/_catalog.md" "$KNOWLEDGE_DIR/_catalog.md" 2>/dev/null
[ ! -f "$KNOWLEDGE_DIR/resources/_processed.md" ] && cp "$PLUGIN_ROOT/templates/knowledge/resources/_processed.md" "$KNOWLEDGE_DIR/resources/_processed.md" 2>/dev/null
[ ! -f "$KNOWLEDGE_DIR/reports/_latest.md" ] && cp "$PLUGIN_ROOT/templates/knowledge/reports/_latest.md" "$KNOWLEDGE_DIR/reports/_latest.md" 2>/dev/null
[ ! -f "$ADOPTED_DIR/_registry.md" ] && cp "$PLUGIN_ROOT/templates/adopted/_registry.md" "$ADOPTED_DIR/_registry.md" 2>/dev/null

exit 0
