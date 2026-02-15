---
name: design-review
description: >
  UI/UX 구현물을 리뷰합니다. 시각적 일관성, 접근성, 반응형 대응,
  디자인 토큰 준수 여부를 검토하고 구체적 개선안을 제시합니다.
  "디자인 리뷰", "UI 리뷰", "접근성 검토" 키워드에 활성화.
context: fork
agent: designer
allowed-tools: Read, Glob, Grep, Bash
---

# UI/UX 디자인 리뷰: $ARGUMENTS

## 리뷰 대상
$ARGUMENTS에 지정된 파일 또는 최근 변경된 UI 파일.
지정되지 않았으면 git diff로 최근 변경된 컴포넌트 파일 식별.

## 리뷰 항목

### 1. 시각적 일관성
- 디자인 토큰(컬러, 타이포그래피, 스페이싱) 준수
- 컴포넌트 간 스타일 일관성
- 기존 프로젝트 패턴과의 정합성

### 2. 접근성 (a11y)
- 색상 대비 (4.5:1 이상)
- alt 텍스트, label 연결
- 키보드 네비게이션
- ARIA 속성 적절성
- 포커스 관리

### 3. 반응형
- 모바일/태블릿/데스크톱 대응
- 브레이크포인트 일관성
- 터치 타겟 크기 (최소 44x44px)

### 4. 성능
- 이미지 최적화 (WebP, lazy loading)
- 불필요한 리렌더링
- 번들 사이즈 영향

### 5. 코드 품질
- 컴포넌트 구조 (단일 책임)
- Props 인터페이스 명확성
- 스타일 관리 방식 일관성

## 결과 형식
```markdown
## Design Review: [대상]
### Score: X/10
### Strengths
### Issues (priority order)
| Priority | Issue | Location | Suggestion |
|----------|-------|----------|------------|
### Recommendations
```
