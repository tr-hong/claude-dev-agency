# 나만의 외주개발사 (devco) — Claude Code Plugin

> 7명의 전문 에이전트가 TDD 기반으로 프로젝트를 기획, 개발, 테스트, 보고하는
> 풀서비스 개발 에이전시 Claude Code 플러그인

[English](#english)

## 특징

- **Golden Test First**: 성공 기준을 먼저 정의하고 TDD로 구현
- **7 에이전트**: concierge, planner, designer, developer, tester, director, ops
- **13 스킬**: 온보딩, 분석, 기획, 병렬빌드, 테스트, 리뷰, 지식관리 등
- **8 커맨드**: /devco:new, /devco:request, /devco:status, /devco:review, /devco:digest, /devco:scan, /devco:adopt, /devco:setup
- **자율 운영**: 개발 중 승인 요청 없이 완료까지 진행
- **지식 시스템**: 경험과 외부 자료를 축적하여 점점 똑똑해지는 에이전시
- **안전장치**: 위험 명령 차단, 프로젝트 외부 파일 수정 차단, TDD 리마인더

## 설치

### 마켓플레이스에서 설치

```
/plugin marketplace add tr-hong/claude-dev-agency
/plugin install devco@claude-dev-agency
```

### 로컬 테스트

```bash
git clone https://github.com/tr-hong/claude-dev-agency.git
claude --plugin-dir ./claude-dev-agency
```

## 초기 설정

```
/devco:setup
```

- `~/.claude/knowledge/` 디렉토리 구조 자동 생성
- 권장 보안 설정 안내

## Quick Start

| 커맨드 | 용도 |
|--------|------|
| `/devco:new [프로젝트]` | 새 프로젝트 시작 |
| `/devco:request [기능]` | 기능 추가/변경 요청 |
| `/devco:status` | 현재 진행 상황 확인 |
| `/devco:review [대상]` | UI/UX 및 코드 리뷰 |
| `/devco:digest [URL]` | 외부 자료 → 지식 축적 |
| `/devco:scan` | 로컬 자료 분석 |
| `/devco:adopt [repo]` | 외부 스킬/에이전트 채택 |
| `/devco:setup` | 초기 설정 |

## 에이전트 직접 실행

```bash
claude --agent devco:concierge
```

## 에이전트 팀

| 에이전트 | 역할 | 모델 |
|----------|------|------|
| **concierge** | 접수 + 총괄 오케스트레이터 | opus |
| **planner** | 기획 + spec + subtask 분할 | opus |
| **designer** | UI/UX 명세 + 리뷰 | sonnet |
| **developer** | 코드 구현 (TDD) | sonnet |
| **tester** | 테스트 + 골든 테스트 검증 | sonnet |
| **director** | PM + 병렬 빌드 + 재시도 루프 | opus |
| **ops** | 지식 관리 + 시스템 개선 | opus |

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

## 안전장치

| 훅 | 타이밍 | 기능 |
|----|--------|------|
| safety-check.sh | PreToolUse (Bash) | rm -rf, sudo rm, force push 등 위험 명령 차단 |
| scope-check.sh | PreToolUse (Write/Edit) | 시스템 디렉토리 파일 수정 차단 |
| tdd-gate.sh | PostToolUse (Write/Edit) | 프로덕션 코드 수정 시 TDD 리마인더 |
| init-knowledge.sh | SessionStart | 지식 디렉토리 자동 초기화 |

## 지식 시스템

```
~/.claude/knowledge/
├── _catalog.md              # 태그별/에이전트별 인덱스
├── entries/                 # 축적된 지식 엔트리
├── resources/               # 로컬 자료 (PDF, 문서 등)
├── reports/                 # 개선 보고서
└── diagrams/                # 다이어그램 자료
```

## 디렉토리 구조

```
claude-dev-agency/
├── .claude-plugin/
│   ├── plugin.json          # 플러그인 매니페스트
│   └── marketplace.json     # 마켓플레이스 설정
├── agents/                  # 7개 에이전트
├── commands/                # 8개 커맨드
├── skills/                  # 13개 스킬
├── hooks/hooks.json         # 훅 설정
├── scripts/                 # 훅 스크립트 5개
├── templates/               # 지식 시스템 템플릿
├── CLAUDE.md                # 플러그인 컨텍스트
├── README.md
└── LICENSE (MIT)
```

## 라이선스

MIT

---

<a name="english"></a>

## English

### Your Personal Dev Agency — Claude Code Plugin

> 7 specialized agents running TDD-based project planning, development, testing, and reporting
> as a full-service development agency Claude Code plugin.

### Features

- **Golden Test First**: Define success criteria before development begins
- **7 Agents**: concierge, planner, designer, developer, tester, director, ops
- **13 Skills**: Onboarding, analysis, planning, parallel build, testing, review, knowledge management
- **8 Commands**: /devco:new, /devco:request, /devco:status, /devco:review, /devco:digest, /devco:scan, /devco:adopt, /devco:setup
- **Autonomous Operation**: No approval requests during development — work continues until completion
- **Knowledge System**: Accumulates experience and external references, getting smarter over time
- **Safety Guards**: Dangerous command blocking, out-of-scope file write prevention, TDD reminders

### Installation

```
/plugin marketplace add tr-hong/claude-dev-agency
/plugin install devco@claude-dev-agency
```

### Quick Start

```
/devco:setup          # Initial setup (creates knowledge directories)
/devco:new my-app     # Start a new project
/devco:request "Add user authentication"  # Request a feature
/devco:status         # Check progress
```

### Direct Agent Invocation

```bash
claude --agent devco:concierge
```

### License

MIT
