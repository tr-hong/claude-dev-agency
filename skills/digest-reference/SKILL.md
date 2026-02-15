---
name: digest-reference
description: >
  URL(들)을 읽고 인사이트/베스트프랙티스를 추출하여 지식으로 축적합니다.
  원본 추적, 중복 체크, 에이전트/스킬 반영 판단까지 수행합니다.
  "자료 분석", "URL 분석", "인사이트 추출", "/digest" 키워드에 활성화.
disable-model-invocation: true
context: fork
agent: ops
allowed-tools: Read, Write, Edit, Bash, WebFetch, WebSearch, Glob, Grep
---

# 레퍼런스 소화: $ARGUMENTS

## 당신은 ops 에이전트입니다.
$ARGUMENTS에 포함된 URL(들)을 분석하여 지식으로 축적합니다.
공백 또는 줄바꿈으로 구분된 여러 URL을 처리할 수 있습니다.

## 각 URL에 대해 수행할 프로세스

### 1. URL 가져오기 + 원본 추적
- WebFetch로 해당 URL 가져오기
- 2차 가공물(인플루언서 요약, X 쓰레드, 블로그 요약글) 여부 판단
- 2차 가공물이면 원본을 찾아 원본 기반으로 추출

### 2. 인사이트 추출
- 핵심 인사이트를 독립적 지식 단위로 분리
- 각 인사이트에 대해: 무엇이 유용한지, 어떤 에이전트에 관련되는지 판단

### 3. 중복/충돌 체크
- ~/.claude/knowledge/_catalog.md의 기존 엔트리와 비교
- 중복: 건너뜀 또는 기존 것 보강
- 충돌: 최신/더 신뢰할 수 있는 쪽 판단

### 4. 엔트리 저장
- ~/.claude/knowledge/entries/E-XXXX-[키워드].md로 저장
- 메타데이터: source, origin URL, tags, applies-to, confidence

### 5. 카탈로그 업데이트
- _catalog.md 갱신

### 6. 에이전트/스킬 반영 판단
- "항상 따라야 하는 원칙" → 에이전트 프롬프트에 삽입
- "특정 워크플로우" → skill 생성/보강
- "알면 좋은 것" → knowledge entry로 충분

### 7. 결과 보고
- ~/.claude/knowledge/reports/IMPROVE-XXX/ 에 보고서 생성
- 채팅으로 요약 전달
