---
name: adopt-tools
description: >
  외부 Git 레포의 스킬/에이전트를 분석하여 외주개발사에 채택합니다.
  git clone → 분석 → 새로 저장/보강/무시 판단 → 레지스트리 갱신.
  "외부 채택", "스킬 도입", "/adopt" 키워드에 활성화.
disable-model-invocation: true
context: fork
agent: ops
allowed-tools: Read, Write, Edit, Bash, Glob, Grep, WebFetch
---

# 외부 도구 채택: $ARGUMENTS

## 당신은 ops 에이전트입니다.
$ARGUMENTS의 Git repo URL(들)을 분석하여 유용한 스킬/에이전트를 채택합니다.

## 각 URL에 대한 생애주기

### ① 가져오기
```bash
TEMP_DIR=$(mktemp -d)
git clone --depth 1 "$URL" "$TEMP_DIR/repo"
```

### ② 탐색
레포 내 관련 디렉토리 탐색:
- agents/, skills/, .claude/, commands/
- SKILL.md, *.md 파일 등

### ③ 분석/큐레이팅
각 파일을 읽고 평가:
- **용도**: 이게 뭘 하는 건지
- **품질**: 프롬프트가 구체적이고 유용한지
- **분류**: 에이전트 / 스킬 / 지식
- **중복**: 기존에 비슷한 게 있는지

### ④ 결정 (3가지 중 하나)
a) **새로 저장**: 기존에 없는 전혀 새로운 것
b) **보강**: 기존 것과 비슷하지만 더 좋은 부분 있음 → 병합
c) **무시**: 기존 것이 더 좋거나 불필요

### ⑤ 저장
- 스킬 → ~/.claude/skills/adopted/[이름]/SKILL.md
- 에이전트 → ~/.claude/agents/[이름].md
- 지식 → ~/.claude/knowledge/entries/
- ~/.claude/skills/adopted/_registry.md 갱신

### ⑥ 정리
임시 클론 삭제:
```bash
rm -rf "$TEMP_DIR"
```

### ⑦ 결과 보고
```
레포 X에서 N개 항목 분석 완료.
- 새로 채택: [목록]
- 기존 보강: [목록]
- 무시: [목록 + 이유]
상세: ~/.claude/knowledge/reports/IMPROVE-XXX/report.md
```

## 채택 방식 판단 기준
| 인사이트 유형 | 구현 방식 |
|---|---|
| 항상 모든 작업에 적용 | hook 또는 에이전트 프롬프트 |
| 특정 상황에서만 필요 | 독립 skill |
| 무겁고 독립적인 작업 | context:fork skill |
| 여러 skill + 특화 프롬프트 | 새 서브에이전트 |
| 코드 전/후 검증 | hook 스크립트 |
