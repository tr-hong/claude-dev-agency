# 나만의 외주개발사 (devco)

7명의 전문 에이전트가 TDD 기반으로 프로젝트를 기획, 개발, 테스트, 보고하는 풀서비스 개발 에이전시.

## 핵심 원칙
1. **골든 테스트 퍼스트**: 성공 기준을 먼저 정의하고 개발 시작
2. **TDD**: Red → Green → Refactor
3. **증거 기반**: 추측 금지, 실제 실행 출력으로 검증
4. **자율 운영**: 개발 중 승인 요청 없이 완료까지 진행
5. **지식 축적**: 경험과 외부 자료를 축적하여 점점 스마트해지는 에이전시

## Quick Start
| 커맨드 | 용도 |
|--------|------|
| `/devco:new [프로젝트]` | 새 프로젝트 시작 (온보딩 → 기획 → 구현 → 보고) |
| `/devco:request [기능]` | 기능 추가/변경 요청 |
| `/devco:status` | 현재 진행 상황 확인 |
| `/devco:review [대상]` | UI/UX 및 코드 리뷰 |
| `/devco:digest [URL]` | 외부 자료 → 지식 축적 |
| `/devco:scan` | 로컬 자료 분석 |
| `/devco:adopt [repo]` | 외부 스킬/에이전트 채택 |
| `/devco:setup` | 초기 설정 (지식 디렉토리 생성) |

## 에이전트 팀
| 에이전트 | 역할 | 모델 |
|----------|------|------|
| concierge | 접수 + 총괄 오케스트레이터 | opus |
| planner | 기획 + spec + subtask 분할 | opus |
| designer | UI/UX 명세 + 리뷰 | sonnet |
| developer | 코드 구현 (TDD) | sonnet |
| tester | 테스트 + 골든 테스트 검증 | sonnet |
| director | PM + 병렬 빌드 + 재시도 | opus |
| ops | 지식 관리 + 시스템 개선 | opus |

## 워크플로우
```
/devco:new 또는 /devco:request
  → concierge (요구사항 + 골든 테스트 정의)
    → planner (spec + subtask + E2E 검증)
      → director (스킬 매칭 + 에이전트 디스패치)
        → developer (TDD 구현) + tester (검증)
      → 골든 테스트 통과까지 루프 (최대 10회)
    → concierge (보고서 생성 + 전달)
```

## 에이전트 직접 실행
```bash
claude --agent devco:concierge
```

## 지식 시스템
- `~/.claude/knowledge/entries/` — 축적된 지식 엔트리
- `~/.claude/knowledge/_catalog.md` — 태그별/에이전트별 인덱스
- `~/.claude/skills/adopted/` — 채택한 외부 스킬
