---
name: report-generate
description: >
  현재 프로젝트의 상태를 파악하여 보고합니다.
  진행 중인 태스크, 프로젝트 구조, 최근 변경사항을 요약합니다.
  "상태 확인", "진행 상황", "/status" 키워드에 활성화.
allowed-tools: Read, Glob, Grep, Bash
---

# 프로젝트 상태 보고

## 현재 프로젝트
!`pwd`

## 보고 프로토콜

### 1. 프로젝트 기본 정보
- .claude/CLAUDE.md 확인 (프로젝트 맥락)
- docs/as-is/_index.md 확인 (현재 상태)

### 2. 태스크 상태
- docs/tasks/_index.md 확인
- 각 TASK의 status.md 확인
- 진행률 계산

### 3. 최근 변경
- git log --oneline -10 (최근 10 커밋)
- git diff --stat (현재 변경사항)

### 4. 채팅 보고 형식 (구조화된 텍스트)
```
프로젝트: [이름]
상태: [초기/진행중/완료]

진행 중인 작업:
  TASK-001: [제목] - [진행률]%
    ├── ST-001: [제목] ✅ done
    ├── ST-002: [제목] 🔄 in-progress
    └── ST-003: [제목] ⏳ pending

최근 변경:
  - [커밋 메시지 1]
  - [커밋 메시지 2]
```

### 5. 아키텍처 도식 관리
보고서 생성 시 docs/reports/_architecture.md 확인:
- 없음 → 새로 생성 (전체 Mermaid 도식)
- 있음 + 구조 변경 → 재생성
- 있음 + 변경 없음 → 캐싱 (재사용)

구조 변경 판단 기준:
- 새 파일/디렉토리 생성
- 기존 파일 삭제/이동
- 새 API 라우트, 컴포넌트 디렉토리, DB 스키마 변경

### 6. 보고서 파일 생성 (요청 시)
docs/reports/REPORT-XXX/ 구조:
- report.md: 전체 보고서 (Mermaid 도식 포함)
- summary.md: 채팅용 3~5문장 핵심 요약

report.md 템플릿:
```markdown
# REPORT-XXX: [제목]
Date: YYYY-MM-DD | Task: TASK-XXX

## 1. 전체 구조
## 2. 이번 작업 범위
## 3. 작업 결과 상세
## 4. 골든 테스트 결과 (있는 경우)
## 5. 검증 결과
## 6. 다음 단계 (선택)
```
