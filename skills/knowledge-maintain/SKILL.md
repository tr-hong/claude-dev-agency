---
name: knowledge-maintain
description: >
  지식 카탈로그와 엔트리를 유지보수합니다. 중복 검출, 충돌 검출,
  카탈로그 동기화, 성장 관리를 수행합니다.
  "지식 정리", "카탈로그 관리" 키워드에 활성화.
context: fork
agent: ops
allowed-tools: Read, Write, Edit, Glob, Grep
---

# 지식 유지보수

## 프로토콜

### 1. 중복 검출
- ~/.claude/knowledge/entries/ 전체 스캔
- 태그와 제목이 유사한 엔트리 쌍 식별
- 중복 발견 시: 병합 또는 supersedes 처리

### 2. 충돌 검출
- 동일 주제에 대해 상반된 조언이 있는 엔트리 식별
- 최신/더 신뢰할 수 있는 쪽을 high confidence로
- 나머지를 low confidence 또는 superseded 처리

### 3. 카탈로그 동기화
- entries/ 파일 목록과 _catalog.md 내용 일치 확인
- 불일치 발견 시 _catalog.md 갱신
- 누락된 엔트리 추가, 삭제된 엔트리 제거

### 4. 성장 관리
- entries/ 파일 수 확인
- 100건 이상이면: low confidence 엔트리 아카이브 제안
- 오래된 엔트리 (6개월+) 중 참조되지 않은 것 식별

### 5. 채택 스킬 정리
- ~/.claude/skills/adopted/_registry.md 확인
- 채택 후 6개월간 미사용 스킬 식별 → 아카이브 제안

### 6. 결과 보고
```
지식 유지보수 완료:
- 중복 병합: N건
- 충돌 해결: N건
- 카탈로그 동기화: N건 수정
- 아카이브 제안: N건
```
