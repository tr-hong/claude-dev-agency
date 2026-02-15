#!/usr/bin/env bash
# Utility script: auto-detect and run project test suite
# Usage: bash post-task-test.sh [project-dir]
# Exit 0 = tests pass, Exit 1 = tests fail or no runner found

PROJECT_DIR="${1:-.}"
cd "$PROJECT_DIR" || exit 1

# Node.js projects
if [ -f "package.json" ]; then
  if grep -q '"test"' package.json 2>/dev/null; then
    echo "[test-runner] Detected: npm test"
    npm test 2>&1
    exit $?
  fi
  if grep -q '"vitest"' package.json 2>/dev/null; then
    echo "[test-runner] Detected: vitest"
    npx vitest run 2>&1
    exit $?
  fi
fi

# Python projects
if [ -f "pyproject.toml" ] || [ -f "pytest.ini" ] || [ -f "setup.cfg" ]; then
  echo "[test-runner] Detected: pytest"
  python3 -m pytest 2>&1 || python -m pytest 2>&1
  exit $?
fi

# Go projects
if [ -f "go.mod" ]; then
  echo "[test-runner] Detected: go test"
  go test ./... 2>&1
  exit $?
fi

# Rust projects
if [ -f "Cargo.toml" ]; then
  echo "[test-runner] Detected: cargo test"
  cargo test 2>&1
  exit $?
fi

echo "[test-runner] No test runner detected in $PROJECT_DIR"
exit 1
