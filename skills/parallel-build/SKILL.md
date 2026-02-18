---
name: parallel-build
description: >
  director 에이전트가 사용하는 병렬 빌드 오케스트레이션 스킬.
  subtask 의존성 그래프를 분석하고, 병렬 가능한 작업을 식별하여
  에이전트를 효율적으로 디스패치합니다.
  "병렬 빌드", "오케스트레이션", "작업 실행" 키워드에 활성화.
context: fork
agent: director
allowed-tools: Read, Write, Edit, Bash, Glob, Grep
---

# 병렬 빌드 오케스트레이션: $ARGUMENTS

## 입력
- docs/tasks/TASK-XXX/ 경로 (또는 계획 텍스트)
- 골든 테스트 명세

## 실행 프로토콜

### 1. 계획 로드
- status.md에서 subtask 목록과 의존성 확인
- 각 subtask 파일 읽기

### 2. 의존성 그래프 분석
```
독립 작업 (의존성 없음): [ST-001, ST-003]
의존적 작업: ST-002 depends on ST-001
             ST-004 depends on ST-003
마지막: ST-FINAL depends on all
```

### 3. 스킬 카탈로그 빌드
director의 "2단계: 스킬 카탈로그 빌드" 프로토콜을 실행하여 사용 가능한 모든 스킬/에이전트를 발견:
1. devco 자체 스킬 스캔: `Glob("skills/*/SKILL.md")` → frontmatter 파싱
2. 설치된 플러그인 스캔: `Read("~/.claude/plugins/installed_plugins.json")` + `Read("~/.claude/settings.json")` → 각 installPath의 skills/ + agents/ 스캔 (disabled 포함)
3. 채택 스킬 스캔: `Read("~/.claude/skills/adopted/_registry.md")` → 테이블 파싱
4. 카탈로그 테이블 생성 → `docs/tasks/TASK-XXX/_skill-catalog.md` 저장
5. 각 subtask 디스패치 시 카탈로그에서 적합한 스킬 1-3개 매칭 → 에이전트 prompt에 주입
6. 카탈로그의 Agents 섹션에서 전문 에이전트가 있으면 subagent_type에 직접 사용 (Enabled=N이면 general-purpose + prompt 주입으로 폴백)

### 4. 에이전트 디스패치
Task tool을 사용하여 순차적으로 (또는 가능하면 병렬로) 에이전트 스폰:
- 각 Task에 subtask 전체 내용 + 프로젝트 규칙 + 스킬 가이드 포함
- 결과를 받아 status.md 갱신

### 5. 골든 테스트 루프
모든 구현 subtask 완료 후:
- tester에게 ST-FINAL 위임
- 실패 시 수정 루프 (최대 10회)
- 통과 시 결과 반환
