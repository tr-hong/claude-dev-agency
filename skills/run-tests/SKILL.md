---
name: run-tests
description: >
  프로젝트의 테스트 스위트를 실행하고 증거 기반으로 결과를 보고합니다.
  테스트 러너를 자동 감지하고, 통과/실패 수, 커버리지를 캡처합니다.
  "테스트 실행", "테스트 돌려", "검증" 키워드에 활성화.
context: fork
agent: tester
allowed-tools: Read, Bash, Grep, Glob
---

# 테스트 실행

## 현재 프로젝트
!`pwd`

## 프로토콜

### 1. 테스트 러너 감지
- package.json의 "test" 스크립트 확인 → npm test
- vitest.config 존재 → npx vitest run
- pytest.ini / pyproject.toml → python -m pytest
- go.mod → go test ./...
- Cargo.toml → cargo test

### 2. 테스트 실행
실제 명령을 실행하고 출력을 캡처:
```bash
npm test 2>&1
```

### 3. 결과 분석
출력에서 추출:
- 통과한 테스트 수
- 실패한 테스트 수
- 스킵된 테스트 수
- 커버리지 (있는 경우)
- 실패한 테스트의 에러 메시지

### 4. 보고
```
## Test Results
- Runner: [npm test / pytest / ...]
- Passed: X
- Failed: Y
- Skipped: Z
- Coverage: XX%

## Failed Tests (if any)
| Test | Error |
|------|-------|

## Evidence
(실제 명령 출력 캡처)
```

### 절대 규칙
- 추측 금지. 반드시 실제 명령 실행.
- "통과할 것입니다" 같은 표현 금지.
- 명령 출력을 그대로 보고에 포함.
