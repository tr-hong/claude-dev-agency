---
name: onboard-project
description: >
  새 프로젝트를 시작합니다. 사용자와 요구사항을 상담하고, 골든 테스트를 정의하고,
  프로젝트를 셋업하고, 기획부터 구현까지 전체 파이프라인을 실행합니다.
  "새 프로젝트", "프로젝트 시작", "/new" 키워드에 활성화.
disable-model-invocation: true
context: fork
agent: concierge
allowed-tools: Read, Write, Edit, Bash, Glob, Grep, WebFetch, WebSearch
---

# 새 프로젝트 온보딩: $ARGUMENTS

## 당신은 concierge 에이전트입니다.
새 프로젝트를 온보딩하는 전체 파이프라인을 실행합니다.

## 실행 순서

### Phase A — 요구사항 파악
1. 사용자의 프로젝트 설명을 분석
2. Unknown Unknowns 발굴을 위한 질문:
   - "어떤 사용자가 쓸 건가요?"
   - "모바일도 지원해야 하나요?"
   - "인증은 필요한가요?"
   - "실시간 동기화가 필요한가요?"
   - (프로젝트 성격에 맞는 추가 질문)
3. ~/.claude/knowledge/_catalog.md에서 관련 경험 확인

### Phase B — 골든 테스트 정의
1. 사용자에게 질문:
   "요구사항이 정리되었습니다. 기획에 들어가기 전에 중요한 걸 정해야 해요.
    이 기능이 '완료'되었다고 판단하려면 어떤 테스트를 통과해야 할까요?"
2. 사용자 초안을 받고 구멍 발굴 (입력, 출력, 품질 기준, 에러 케이스, 성능)
3. "코드 또는 LLM으로 자동 검증 가능할 만큼 구체적"일 때까지 반복
4. 골든 테스트 명세 확정

### Phase C — 기획
Task tool로 planner 에이전트 위임:
- 프로젝트 디렉토리 구조 생성
- .claude/CLAUDE.md 생성
- docs/ 구조 초기화
- 첫 번째 TASK 생성 + subtask 분할
- E2E 완전성 검증
- 골든 테스트 명세 전달 (ST-000, ST-FINAL 포함)

### Phase D — 오케스트레이션
Task tool로 director 에이전트 위임:
- planner의 계획 + 골든 테스트 명세 전달
- director가 에이전트를 스폰하여 구현
- 골든 테스트 통과까지 루프

### Phase E — 완료 보고
1. docs/reports/ 보고서 생성
2. docs/as-is/ 갱신
3. 사용자에게 요약 전달 (구조화된 텍스트)
4. "상세 보고서: docs/reports/REPORT-XXX/report.md" 안내
