# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.1.0] - 2024-01-XX

### 새로운 기능
- ✨ **픽셀 불투명도 조절** - `pixelOpacity` 속성으로 반투명 효과 구현
- 🎨 **새로운 반투명 스타일** 추가:
  - `PixelArtStyle.translucent()` - 기본 반투명 스타일
  - `PixelArtStyle.glass()` - 글래스 효과 스타일
  - `PixelArtStyle.hologram()` - 홀로그램 효과 스타일
- 🔧 **향상된 예제 앱**:
  - 불투명도 조절 슬라이더 추가
  - 불투명도 효과 갤러리 섹션 추가
  - 체크무늬 배경으로 반투명 효과 시각화

### 개선사항
- 📖 문서 업데이트 및 새로운 기능 설명 추가
- 🎮 예제 앱에서 반투명 효과를 더 잘 보여주는 체크무늬 배경 구현

## [1.0.0] - 2024-01-XX

### 새로운 기능
- ✨ **픽셀 간격 조절** - `pixelSpacing` 속성으로 픽셀 사이 간격 설정
- 🌟 **그림자 효과** - `enableShadow`, `shadowColor`, `shadowOffset`, `shadowBlur` 속성
- 🎮 **레트로 스타일 프리셋**:
  - `PixelArtStyle.neon80s()` - 80년대 네온 스타일
  - `PixelArtStyle.gameboy()` - 게임보이 클래식 스타일
  - `PixelArtStyle.crtMonitor()` - CRT 모니터 스타일
  - `PixelArtStyle.retroArcade()` - 레트로 아케이드 스타일
  - `PixelArtStyle.withSpacing()` - 픽셀 간격 스타일
  - `PixelArtStyle.withShadow()` - 그림자 효과 스타일
- 🎨 **RetroColors 팔레트** - 80년대 네온, 게임보이, CRT 색상 컬렉션
- 📱 **멀티플랫폼 지원** - 모든 Flutter 플랫폼 (iOS, Android, Web, macOS, Windows, Linux)

### 개선사항
- 🔧 향상된 예제 앱 with 레트로 스타일 갤러리
- 📖 완전히 새로운 문서화
- 🧪 포괄적인 단위 테스트

## [0.1.0] - 2024-01-XX

### 초기 릴리스
- 📝 텍스트를 픽셀아트로 변환하는 기본 기능
- 🎨 픽셀 크기, 색상 커스터마이징
- 📐 그리드 표시 옵션
- 🔤 단일 줄 및 여러 줄 텍스트 지원
- ⚙️ 폰트 설정 (크기, 패밀리, 굵기, 임계값)
- 📱 기본 Flutter 위젯으로 구현

### Added
- 초기 버전 릴리스
- `PixelMatrix` 클래스 - 픽셀 매트릭스 관리
- `PixelFontConfig` 클래스 - 폰트 설정 관리
- `PixelArtStyle` 클래스 - 픽셀아트 스타일 관리
- `TextToPixelConverter` 클래스 - 텍스트를 픽셀로 변환
- `PixelArtPainter` 클래스 - 픽셀아트 렌더링
- `PixelTextWidget` 위젯 - 메인 픽셀 텍스트 위젯
- `PixelText` 유틸리티 클래스 - 간편한 픽셀 텍스트 생성
- 단일 줄 및 여러 줄 텍스트 지원
- 그리드 표시 옵션
- 다양한 픽셀 크기 및 색상 지원
- 커스텀 폰트 설정 지원
- 포괄적인 단위 테스트
- 예제 앱
- 완전한 API 문서

### Features
- 📝 텍스트를 픽셀아트로 실시간 변환
- 🎨 완전히 커스터마이징 가능한 스타일
- 📏 여러 줄 텍스트 지원
- ⚙️ 폰트 설정 (크기, 가족, 임계값)
- 🔧 픽셀 크기, 색상, 그리드 설정
- 🚀 간단하고 직관적인 API
