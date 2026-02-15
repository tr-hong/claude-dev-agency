---
name: task-validate
description: >
  골든 테스트를 실행하여 태스크의 완료 여부를 검증합니다.
  결정론적 검증(코드)을 먼저 실행하고, LLM 판정(에이전트)을 후속 실행합니다.
  "골든 테스트", "완료 검증", "task validate" 키워드에 활성화.
context: fork
agent: tester
allowed-tools: Read, Bash, Grep, Glob, Write
---

# 골든 테스트 검증: $ARGUMENTS

## 프로토콜

### 1. 골든 테스트 명세 로드
- docs/tasks/TASK-XXX/golden-spec.md 읽기
- tests/golden/ 디렉토리 확인

### 2. 결정론적 검증 (코드)
golden-test.sh 또는 개별 검증 스크립트 실행:
```bash
bash tests/golden/golden-test.sh 2>&1
```
각 G-N 항목의 PASS/FAIL 결과 캡처.

**하나라도 FAIL → 즉시 실패 보고 (LLM 검증 스킵)**
코드 검증이 전부 PASS일 때만 다음 단계로.

### 3. LLM 검증 (있는 경우)
golden-judge.md가 있으면:
- 판정 기준에 따라 시스템 출력물 평가
- 점수 + 판정 결과 기록

### 4. 종합 결과
```
## Golden Test Results (Run #N)

### Summary
Overall: PASS | FAIL
Runs so far: N

### Details
| # | Item | Type | Result | Detail |
|---|------|------|--------|--------|
| G-1 | ... | code | PASS | ... |
| G-2 | ... | code | FAIL | ... |
| G-3 | ... | llm | PASS | score: 8.2 |

### Failed Items (if any)
G-2: [구체적 실패 원인 — 어떤 파일에서, 왜, 어떻게]

### Recommendation
[실패 항목에 대한 수정 방향 제안]
```

### 5. 실행 로그 기록
tests/golden/golden-runs.log에 결과 추가:
```
Run #N | YYYY-MM-DD HH:MM | PASS/FAIL | Failed: G-X, G-Y | Notes
```

## 절대 규칙
- 모든 검증은 실제 실행. 추측 금지.
- 코드 검증이 먼저. LLM 검증은 코드 전체 통과 후에만.
- 실패 정보는 최대한 구체적으로 (파일명, 줄 번호, 기대값 vs 실제값).
