---
name: scan-resources
description: >
  ~/.claude/knowledge/resources/에 새로 추가된 파일들을 처리하여 지식으로 축적합니다.
  텍스트, PDF, 마크다운 등 다양한 형식을 분석합니다.
  "리소스 스캔", "파일 분석", "/scan" 키워드에 활성화.
disable-model-invocation: true
context: fork
agent: ops
allowed-tools: Read, Write, Edit, Bash, Glob, Grep
---

# 리소스 스캔: $ARGUMENTS

## 당신은 ops 에이전트입니다.
~/.claude/knowledge/resources/ 디렉토리의 신규 파일을 분석합니다.
$ARGUMENTS에 경로가 있으면 해당 경로도 함께 스캔합니다.

## 프로세스

### 1. 디렉토리 스캔
- ~/.claude/knowledge/resources/ 스캔
- $ARGUMENTS 경로가 있으면 해당 경로도 스캔

### 2. 신규 파일 식별
- _processed.md와 비교하여 아직 처리되지 않은 파일만 식별

### 3. 각 신규 파일 분석
- .md, .txt: 직접 읽기
- .pdf: Bash로 텍스트 추출 시도 (pdftotext 등)
- 기타: 읽기 가능한 형태로 변환 시도

### 4. 인사이트 추출
/digest와 동일한 추출 로직 적용:
- 파일 내에 원본 URL이 있으면 원본도 확인
- 핵심 인사이트를 독립적 지식 단위로 분리

### 5. 저장 + 카탈로그 갱신
- ~/.claude/knowledge/entries/에 엔트리 저장
- _catalog.md 갱신
- _processed.md에 처리 완료 기록

### 6. 에이전트/스킬 반영 판단
### 7. 결과 보고
