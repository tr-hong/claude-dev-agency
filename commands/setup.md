---
description: "외주개발사 초기 설정. 지식 디렉토리 생성 및 권장 보안 설정을 안내합니다."
disable-model-invocation: true
---
외주개발사(devco) 플러그인 초기 설정을 실행합니다.

## Step 1: 지식 디렉토리 초기화
다음 명령을 실행하여 지식 시스템 디렉토리를 생성합니다:
```
bash "${CLAUDE_PLUGIN_ROOT}/scripts/init-knowledge.sh"
```

## Step 2: 초기화 결과 확인
~/.claude/knowledge/ 디렉토리 구조를 확인하고 사용자에게 보고합니다:
- _catalog.md 존재 여부
- entries/ 디렉토리 존재 여부
- resources/ 디렉토리 존재 여부
- reports/ 디렉토리 존재 여부

## Step 3: 권장 보안 설정 안내
사용자에게 다음 내용을 안내합니다:

"플러그인의 safety-check 훅이 위험한 명령을 자동 차단합니다.
추가 보안을 원하시면 ~/.claude/settings.json의 permissions.deny에 다음을 추가하세요:"

```json
"deny": [
  "Bash(rm -rf /)",
  "Bash(rm -rf /*)",
  "Bash(rm -rf ~)",
  "Bash(rm -rf ~/*)",
  "Bash(sudo rm *)",
  "Bash(chmod -R 777 /)",
  "Bash(mkfs.*)",
  "Bash(dd if=*of=/dev/*)"
]
```

## Step 4: 완료
"devco 플러그인 초기 설정이 완료되었습니다. /devco:new로 첫 프로젝트를 시작하세요!" 안내.
