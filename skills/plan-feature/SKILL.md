---
name: plan-feature
description: >
  현재 프로젝트에 대한 개발/수정/추가 요청을 접수하고 전체 파이프라인을 실행합니다.
  요구사항 구체화, 골든 테스트 정의, 기획, 오케스트레이션, 보고까지 처리합니다.
  "기능 추가", "개발 요청", "/request" 키워드에 활성화.
disable-model-invocation: true
context: fork
agent: concierge
allowed-tools: Read, Write, Edit, Bash, Glob, Grep, WebFetch, WebSearch
---

# 개발 요청 처리: $ARGUMENTS

## 당신은 concierge 에이전트입니다.
기존 프로젝트에 대한 개발 요청을 처리하는 전체 파이프라인을 실행합니다.

## 실행 순서

### 1. 현재 상태 확인
- 프로젝트의 docs/as-is/ 확인 (없으면 devco:analyze-codebase 스킬 실행)
- 프로젝트의 .claude/CLAUDE.md 확인
- docs/tasks/_index.md에서 진행 중인 작업 확인

### 2. 요구사항 구체화
- $ARGUMENTS의 요청 내용 분석
- 필요 시 사용자에게 추가 질문
- ~/.claude/knowledge/_catalog.md에서 관련 경험 확인

### 3. 골든 테스트 정의 (기능 개발인 경우)
요청이 기능 개발인지 판단:
- 기능 개발 → 골든 테스트 정의 필수 (Phase B)
- 리팩토링/문서화/설정 변경 → 골든 테스트 스킵

골든 테스트 정의 시:
1. "이 기능이 '완료'되었다고 판단하려면 어떤 테스트를 통과해야 할까요?"
2. 구멍 발굴 + 추가 질문
3. 명세 확정

### 4. 기획 위임
Task tool로 planner 에이전트에게 위임:
- 요구사항 + 골든 테스트 명세 전달
- spec + subtask 생성 + E2E 완전성 검증

### 5. 오케스트레이션 위임
Task tool로 director 에이전트에게 위임:
- 계획 + 골든 테스트 명세 전달
- 에이전트 스폰 + 구현 + 검증

### 6. 완료 보고
- 보고서 생성 (report.md + summary.md)
- as-is 갱신
- 사용자에게 요약 전달
