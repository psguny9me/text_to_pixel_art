<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

# Text to Pixel Art

Flutter에서 텍스트를 픽셀아트로 변환하는 패키지입니다. 다양한 레트로 스타일과 커스터마이징 옵션을 제공합니다.

## 🚀 멀티플랫폼 지원

이 패키지는 Flutter의 모든 플랫폼을 지원합니다:

- ✅ Android
- ✅ iOS  
- ✅ Web
- ✅ macOS
- ✅ Windows
- ✅ Linux

순수 Dart/Flutter 위젯을 사용하므로 네이티브 플러그인 없이 모든 플랫폼에서 동일하게 작동합니다.

## 특징

- ✨ 텍스트를 픽셀아트로 변환
- 🎮 다양한 레트로 스타일 (80년대 네온, 게임보이, CRT 모니터 등)
- 🎨 커스터마이징 가능한 픽셀 크기, 색상, 간격
- 🌟 그림자 효과 지원
- 👻 픽셀 불투명도 조절 (반투명 효과)
- ✏️ **얇은 폰트 지원** (1픽셀 두께의 섬세한 텍스트)
- 📝 **향상된 멀티라인 지원** (여러 줄 텍스트 완벽 처리)
- 📐 그리드 표시 옵션
- 📱 멀티플랫폼 지원 (iOS, Android, Web, macOS, Windows, Linux)
- 🔤 단일 줄 및 여러 줄 텍스트 지원

## 설치

`pubspec.yaml` 파일에 다음을 추가하세요:

```yaml
dependencies:
  text_to_pixel_art: ^1.0.0
```

그리고 다음 명령어를 실행하세요:

```bash
flutter pub get
```

## 사용법

### 기본 사용법

#### 간단한 픽셀 텍스트

```dart
import 'package:text_to_pixel_art/text_to_pixel_art.dart';

// 기본 픽셀 텍스트 (얇은 폰트 사용)
PixelText.create(
  text: 'HELLO',
  pixelSize: 4.0,
  pixelColor: Colors.black,
)

// 큰 크기 픽셀 텍스트
PixelText.large(
  text: 'BIG TEXT',
  pixelColor: Colors.blue,
)

// 작은 크기 픽셀 텍스트
PixelText.small(
  text: 'small',
  pixelColor: Colors.green,
)
```

#### 1픽셀 두께의 얇은 폰트

```dart
// 매우 얇은 1픽셀 두께 텍스트
PixelTextWidget(
  text: 'THIN PIXEL',
  fontConfig: PixelFontConfig.thin(),
  artStyle: PixelArtStyle(
    pixelSize: 4.0,
    pixelColor: Colors.black,
  ),
)

// 사용자 정의 얇은 폰트
PixelTextWidget(
  text: 'CUSTOM THIN',
  fontConfig: PixelFontConfig.thin(
    fontSize: 18.0,
    textColor: Colors.blue,
  ),
  artStyle: PixelArtStyle(pixelSize: 3.0),
)
```

#### 8x8 고정 크기 픽셀 폰트

```dart
// 각 글자가 정확히 8x8 픽셀로 렌더링
PixelTextWidget(
  text: 'RETRO',
  fontConfig: PixelFontConfig.fixed8x8(),
  artStyle: PixelArtStyle(
    pixelSize: 4.0,
    showGrid: true, // 8x8 격자 표시
  ),
)

// 8x16 크기 (알파벳에 더 적합)
PixelTextWidget(
  text: 'HELLO',
  fontConfig: PixelFontConfig.fixed8x16(),
  artStyle: PixelArtStyle(
    pixelSize: 3.0,
    showGrid: true,
  ),
)

// 6x8 작은 크기
PixelTextWidget(
  text: 'SMALL',
  fontConfig: PixelFontConfig.fixed6x8(),
  artStyle: PixelArtStyle(pixelSize: 5.0),
)

// 12x16 큰 크기
PixelTextWidget(
  text: 'BIG',
  fontConfig: PixelFontConfig.fixed12x16(),
  artStyle: PixelArtStyle(pixelSize: 2.0),
)

// 커스텀 고정 크기 (예: 12x16)
PixelTextWidget(
  text: 'CUSTOM',
  fontConfig: PixelFontConfig.fixedSize(
    letterWidth: 12,
    letterHeight: 16,
  ),
  artStyle: PixelArtStyle(pixelSize: 3.0),
)
```

#### 멀티라인 텍스트

```dart
// 여러 줄 텍스트 (자동 줄바꿈 처리)
PixelTextWidget.multiLine(
  text: 'HELLO\nWORLD\nPIXEL\nART',
  fontConfig: PixelFontConfig.multiline(),
  artStyle: PixelArtStyle(
    pixelSize: 4.0,
    pixelColor: Colors.purple,
  ),
)
```

#### 고급 설정

```dart
PixelTextWidget(
  text: 'RETRO GAME',
  fontConfig: PixelFontConfig(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    textColor: Colors.white,
  ),
  artStyle: PixelArtStyle(
    pixelSize: 6.0,
    pixelColor: Colors.cyan,
    backgroundColor: Colors.black,
    pixelSpacing: 1.0,
    pixelOpacity: 0.8, // 불투명도 설정 (0.0 ~ 1.0)
    enableShadow: true,
    shadowColor: Colors.blue,
    shadowOffset: Offset(2.0, 2.0),
    shadowBlur: 3.0,
    showGrid: true,
  ),
)
```

## 레트로 스타일 프리셋

### 1. 80년대 네온 스타일
```dart
PixelTextWidget(
  text: 'NEON 80s',
  artStyle: PixelArtStyle.neon80s(),
)
```

### 2. 게임보이 스타일
```dart
PixelTextWidget(
  text: 'GAMEBOY',
  artStyle: PixelArtStyle.gameboy(),
)
```

### 3. CRT 모니터 스타일
```dart
PixelTextWidget(
  text: 'CRT MONITOR',
  artStyle: PixelArtStyle.crtMonitor(),
)
```

### 4. 레트로 아케이드 스타일
```dart
PixelTextWidget(
  text: 'ARCADE',
  artStyle: PixelArtStyle.retroArcade(),
)
```

### 5. 반투명 스타일
```dart
PixelTextWidget(
  text: 'TRANSLUCENT',
  artStyle: PixelArtStyle.translucent(
    pixelOpacity: 0.6,
  ),
)
```

### 6. 글래스 효과 스타일
```dart
PixelTextWidget(
  text: 'GLASS',
  artStyle: PixelArtStyle.glass(),
)
```

### 7. 홀로그램 효과 스타일
```dart
PixelTextWidget(
  text: 'HOLOGRAM',
  artStyle: PixelArtStyle.hologram(),
)
```

## 색상 팔레트

### 80년대 네온 컬러
```dart
RetroColors.neonPink      // #FF10F0
RetroColors.neonBlue      // #00FFFF
RetroColors.neonGreen     // #39FF14
RetroColors.neonYellow    // #FFFF00
RetroColors.neonOrange    // #FF6600
RetroColors.neonPurple    // #9D00FF
```

### 게임보이 컬러
```dart
RetroColors.gameboyGreen       // #8BAC0F
RetroColors.gameboyDarkGreen   // #306230
RetroColors.gameboyLightGreen  // #9BBD0F
RetroColors.gameboyBackground  // #0F380F
```

### CRT 모니터 컬러
```dart
RetroColors.crtGreen       // #00FF41
RetroColors.crtAmber       // #FFB000
RetroColors.crtWhite       // #FFFFFF
RetroColors.crtBackground  // #000000
```

## 설정 옵션

### PixelFontConfig

| 속성 | 타입 | 기본값 | 설명 |
|-----|------|-------|------|
| fontSize | double | 16.0 | 폰트 크기 |
| fontFamily | String? | null | 폰트 패밀리 |
| fontWeight | FontWeight | FontWeight.w100 | 폰트 굵기 (기본: 가장 얇음) |
| textColor | Color | Colors.black | 텍스트 색상 |
| backgroundColor | Color | Colors.transparent | 배경 색상 |
| threshold | double | 80 | 픽셀 변환 임계값 (더 민감함) |
| antiAlias | bool | false | 안티앨리어싱 |
| letterPixelWidth | int? | null | 글자당 픽셀 너비 (고정 크기) |
| letterPixelHeight | int? | null | 글자당 픽셀 높이 (고정 크기) |

#### Factory 생성자

- `PixelFontConfig.thin()` - 1픽셀 두께의 매우 얇은 폰트 (threshold: 100)
- `PixelFontConfig.normal()` - 일반 두께 폰트 (threshold: 128)
- `PixelFontConfig.fixed6x8()` - 6x8 픽셀 고정 크기 폰트 (작은 크기)
- `PixelFontConfig.fixed8x8()` - 8x8 픽셀 고정 크기 폰트 (기호용)
- `PixelFontConfig.fixed8x16()` - 8x16 픽셀 고정 크기 폰트 (알파벳 권장)
- `PixelFontConfig.fixed12x16()` - 12x16 픽셀 고정 크기 폰트 (큰 크기)
- `PixelFontConfig.fixedSize()` - 커스텀 고정 크기 폰트
- `PixelFontConfig.multiline()` - 멀티라인 텍스트에 최적화
- `PixelFontConfig.monospace()` - 기본 모노스페이스 폰트
- `PixelFontConfig.small()` - 작은 크기 폰트
- `PixelFontConfig.large()` - 큰 크기 폰트

#### 폰트 유형 비교

```dart
// 얇은 폰트 - 1픽셀 두께의 섬세한 텍스트
PixelTextWidget(
  text: 'THIN FONT',
  fontConfig: PixelFontConfig.thin(),
  artStyle: PixelArtStyle(pixelSize: 4.0),
)

// 일반 폰트 - 표준 두께 텍스트
PixelTextWidget(
  text: 'NORMAL FONT',
  fontConfig: PixelFontConfig.normal(),
  artStyle: PixelArtStyle(pixelSize: 4.0),
)

// 8x8 고정 크기 - 각 글자가 정확히 8x8 픽셀
PixelTextWidget(
  text: '8X8 FIXED',
  fontConfig: PixelFontConfig.fixed8x8(),
  artStyle: PixelArtStyle(
    pixelSize: 4.0,
    showGrid: true, // 격자 표시로 8x8 구조 확인
  ),
)
```

### PixelArtStyle

| 속성 | 타입 | 기본값 | 설명 |
|-----|------|-------|------|
| pixelSize | double | 4.0 | 픽셀 크기 |
| pixelColor | Color | Colors.black | 픽셀 색상 |
| backgroundColor | Color | Colors.transparent | 배경 색상 |
| pixelSpacing | double | 0.0 | 픽셀 간격 |
| pixelOpacity | double | 1.0 | 픽셀 불투명도 (0.0 ~ 1.0) |
| showGrid | bool | false | 그리드 표시 |
| gridColor | Color | Colors.grey | 그리드 색상 |
| gridLineWidth | double | 0.5 | 그리드 선 굵기 |
| enableShadow | bool | false | 그림자 효과 |
| shadowColor | Color | Colors.black54 | 그림자 색상 |
| shadowOffset | Offset | Offset(1.0, 1.0) | 그림자 오프셋 |
| shadowBlur | double | 2.0 | 그림자 블러 |

## 📱 플랫폼별 실행 방법

### Android/iOS
```bash
flutter run
```

### 웹
```bash
flutter run -d chrome
```

### macOS
```bash
flutter run -d macos
```

### Windows
```bash
flutter run -d windows
```

### Linux
```bash
flutter run -d linux
```

## API 참조

### PixelTextWidget

메인 위젯 클래스입니다.

#### 속성

- `text`: 표시할 텍스트
- `fontConfig`: 폰트 설정
- `artStyle`: 픽셀아트 스타일
- `isMultiline`: 여러 줄 모드 여부

#### 팩토리 생성자

- `PixelTextWidget.singleLine()`: 단일 줄 텍스트
- `PixelTextWidget.multiLine()`: 여러 줄 텍스트

### PixelFontConfig

폰트 설정을 관리하는 클래스입니다.

#### 속성

- `fontSize`: 폰트 크기 (기본값: 16.0)
- `fontFamily`: 폰트 가족 (기본값: 'monospace')
- `fontWeight`: 폰트 두께
- `textColor`: 텍스트 색상
- `backgroundColor`: 배경 색상
- `threshold`: 픽셀 임계값 (기본값: 128)
- `useAntiAliasing`: 안티앨리어싱 사용 여부

#### 팩토리 생성자

- `PixelFontConfig.monospace()`: 모노스페이스 폰트
- `PixelFontConfig.small()`: 작은 크기
- `PixelFontConfig.large()`: 큰 크기

### PixelArtStyle

픽셀아트 스타일을 관리하는 클래스입니다.

#### 속성

- `pixelSize`: 픽셀 크기 (기본값: 4.0)
- `pixelColor`: 픽셀 색상
- `backgroundColor`: 배경 색상
- `showGrid`: 그리드 표시 여부
- `gridColor`: 그리드 색상
- `gridLineWidth`: 그리드 선 두께

#### 팩토리 생성자

- `PixelArtStyle.defaultStyle()`: 기본 스타일
- `PixelArtStyle.large()`: 큰 픽셀
- `PixelArtStyle.small()`: 작은 픽셀
- `PixelArtStyle.withGrid()`: 그리드 포함

### PixelText

간단한 픽셀 텍스트 생성을 위한 유틸리티 클래스입니다.

#### 정적 메서드

- `PixelText.create()`: 기본 픽셀 텍스트
- `PixelText.large()`: 큰 크기 픽셀 텍스트
- `PixelText.small()`: 작은 크기 픽셀 텍스트

## 예제

예제 앱을 실행하여 모든 기능을 체험해보세요:

```bash
cd example
flutter run
```

예제 앱에서는 다음을 확인할 수 있습니다:
- 📝 실시간 텍스트 입력 및 변환
- 🎛️ 모든 설정 옵션 조절
- 🎨 레트로 스타일 갤러리
- 👻 불투명도 효과 데모
- 🌈 색상 팔레트 미리보기

## 요구 사항

- Flutter 3.0.0 이상
- Dart 3.6.0 이상

## 호환성

- ✅ Android API 16+
- ✅ iOS 9.0+
- ✅ Web (모든 모던 브라우저)
- ✅ macOS 10.14+
- ✅ Windows 7+
- ✅ Linux (Ubuntu 18.04+)

## 라이선스

이 프로젝트는 MIT 라이선스 하에 배포됩니다. 자세한 내용은 [LICENSE](LICENSE) 파일을 참조하세요.

## 기여

버그 리포트나 기능 요청은 [GitHub Issues](https://github.com/psguny9me/text_to_pixel_art/issues)에 제출해 주세요.

## 지원

문의사항이 있으시면 [GitHub](https://github.com/psguny9me/text_to_pixel_art)를 방문해 주세요.
