---
name: analyze-codebase
description: >
  기존 코드베이스의 현재 상태를 분석하여 docs/as-is/ 문서를 생성합니다.
  디렉토리 구조, 기술 스택, 아키텍처 패턴, 의존성, 코드 품질을 파악합니다.
  "코드 분석", "현재 상태", "as-is" 키워드에 활성화.
context: fork
agent: planner
allowed-tools: Read, Glob, Grep, Bash, Write
---

# 코드베이스 분석

## 분석 대상
현재 프로젝트 디렉토리: !`pwd`

## 분석 프로토콜

### 1. 디렉토리 구조 스캔
- 전체 파일 트리 생성 (node_modules, .git 등 제외)
- 주요 디렉토리의 역할 식별

### 2. 기술 스택 식별
- package.json, pyproject.toml, Cargo.toml 등에서 의존성 분석
- 프레임워크: Next.js, React, FastAPI, Express 등
- 언어: TypeScript, Python, Rust 등
- DB: Supabase, PostgreSQL, MongoDB 등
- UI: Tailwind, shadcn/ui, Material UI 등

### 3. 아키텍처 패턴 분석
- 라우팅 구조 (App Router, Pages Router, API routes)
- 상태 관리 패턴
- 데이터 페칭 패턴
- 인증/인가 구조
- 에러 처리 패턴

### 4. 코드 품질 빠른 점검
- 테스트 존재 여부 + 커버리지
- 린트 설정 (ESLint, Prettier)
- 타입 체크 (tsconfig 엄격도)

### 5. 문서 생성
docs/as-is/_index.md에 분석 결과 작성:

```markdown
# As-Is: [프로젝트명]
Last analyzed: YYYY-MM-DD

## Tech Stack
## Directory Structure
## Architecture
## Dependencies (key)
## Code Quality
## Known Issues / Tech Debt
```
