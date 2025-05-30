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
- `threshold`: 픽셀 임계값 (기본값: 80)
- `useAntiAliasing`: 안티앨리어싱 사용 여부
- `letterPixelWidth`: 글자당 픽셀 너비 (고정 크기)
- `letterPixelHeight`: 글자당 픽셀 높이 (고정 크기)

#### 사용 예제

```dart
// 기본 설정
PixelFontConfig()

// 커스텀 설정
PixelFontConfig(
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
  threshold: 100,
  useAntiAliasing: true,
)

// 고정 크기 설정
PixelFontConfig(
  fontSize: 16.0,
  letterPixelWidth: 8,
  letterPixelHeight: 16,
  threshold: 70,
)
```

## 특징

- ✨ 텍스트를 픽셀아트로 변환
- 🎮 게임보이 LCD 스타일 예제 (도트 매트릭스 효과)
- 🎨 완전 커스터마이징 가능한 픽셀 크기, 색상, 간격
- 🌟 그림자 효과 지원
- 👻 픽셀 불투명도 조절 (반투명 효과)
- 📐 고정 크기 폰트 지원 (8x8, 8x16 등)
- 📝 향상된 멀티라인 지원 (여러 줄 텍스트 완벽 처리)
- 🔧 실시간 설정 조정 가능한 예제 앱
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

// 기본 픽셀 텍스트
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

#### 커스터마이징 가능한 픽셀 텍스트

```dart
// 완전 커스터마이징 가능한 픽셀 텍스트
PixelTextWidget(
  text: 'CUSTOM',
  fontConfig: PixelFontConfig(
    fontSize: 20.0,
    fontWeight: FontWeight.w100,
    threshold: 80,
    useAntiAliasing: false,
  ),
  artStyle: PixelArtStyle(
    pixelSize: 4.0,
    pixelColor: Colors.blue,
    pixelSpacing: 1.0,
    pixelOpacity: 0.9,
    enableShadow: true,
  ),
)
```

#### 고정 크기 픽셀 폰트

```dart
// 각 글자가 정확히 8x8 픽셀로 렌더링
PixelTextWidget(
  text: 'RETRO',
  fontConfig: PixelFontConfig(
    fontSize: 16.0,
    letterPixelWidth: 8,
    letterPixelHeight: 8,
  ),
  artStyle: PixelArtStyle(
    pixelSize: 4.0,
    showGrid: true, // 8x8 격자 표시
  ),
)

// 8x16 크기 (알파벳에 더 적합)
PixelTextWidget(
  text: 'HELLO',
  fontConfig: PixelFontConfig(
    fontSize: 18.0,
    letterPixelWidth: 8,
    letterPixelHeight: 16,
  ),
  artStyle: PixelArtStyle(
    pixelSize: 3.0,
    showGrid: true,
  ),
)

// 커스텀 고정 크기
PixelTextWidget(
  text: 'CUSTOM',
  fontConfig: PixelFontConfig(
    fontSize: 20.0,
    letterPixelWidth: 12,
    letterPixelHeight: 16,
  ),
  artStyle: PixelArtStyle(pixelSize: 3.0),
)
```

#### 멀티라인 텍스트

```dart
// 여러 줄 텍스트 (자동 줄바꿈 처리)
PixelTextWidget.multiLine(
  text: 'HELLO\nWORLD\nPIXEL\nART',
  fontConfig: PixelFontConfig(
    fontSize: 16.0,
    fontWeight: FontWeight.w100,
  ),
  artStyle: PixelArtStyle(
    pixelSize: 4.0,
    pixelColor: Colors.purple,
  ),
)
```

#### 🎮 게임보이 LCD 스타일 예제

```dart
// 게임보이 LCD 스타일 텍스트
Container(
  padding: EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Color(0xFF9BBD0F), // 게임보이 LCD 배경색
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: Colors.grey[600]!, width: 3),
  ),
  child: Column(
    children: [
      // 메인 텍스트
      PixelTextWidget(
        text: 'Hello',
        fontConfig: PixelFontConfig(
          fontSize: 16.0,
          fontWeight: FontWeight.w100,
          threshold: 70,
          textColor: Color(0xFF0F380F), // 어두운 녹색
        ),
        artStyle: PixelArtStyle(
          pixelSize: 3.0,
          pixelColor: Color(0xFF0F380F),
          backgroundColor: Color(0xFF9BBD0F),
          pixelSpacing: 1.0, // 도트 매트릭스 효과
          pixelOpacity: 0.9,
          enableShadow: true,
        ),
      ),
      
      SizedBox(height: 16),
      
      // 서브 텍스트 (멀티라인)
      PixelTextWidget.multiLine(
        text: 'PRESS START\n\nTO PLAY',
        fontConfig: PixelFontConfig(
          fontSize: 14.0,
          fontWeight: FontWeight.w100,
          threshold: 70,
          textColor: Color(0xFF0F380F),
          letterPixelWidth: 6,
          letterPixelHeight: 8,
        ),
        artStyle: PixelArtStyle(
          pixelSize: 2.0,
          pixelColor: Color(0xFF0F380F),
          backgroundColor: Color(0xFF9BBD0F),
          pixelSpacing: 0.5,
          pixelOpacity: 0.9,
          enableShadow: true,
        ),
      ),
    ],
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
    threshold: 128,
    useAntiAliasing: false,
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

## 레트로 스타일 예제

### 80년대 네온 스타일
```dart
PixelTextWidget(
  text: 'NEON 80s',
  artStyle: PixelArtStyle(
    pixelSize: 6.0,
    pixelColor: Color(0xFFFF10F0), // 네온 핑크
    backgroundColor: Color(0xFF2D1B69), // 어두운 보라
    pixelSpacing: 1.0,
    enableShadow: true,
    shadowColor: Color(0xFFFF10F0).withValues(alpha: 0.5),
    shadowOffset: Offset(2.0, 2.0),
    shadowBlur: 4.0,
  ),
)
```

### 게임보이 스타일
```dart
PixelTextWidget(
  text: 'GAMEBOY',
  artStyle: PixelArtStyle(
    pixelSize: 4.0,
    pixelColor: Color(0xFF8BAC0F), // 게임보이 녹색
    backgroundColor: Color(0xFF0F380F), // 어두운 녹색
    pixelSpacing: 0.5,
    enableShadow: true,
    shadowColor: Color(0xFF306230), // 게임보이 어두운 녹색
    shadowOffset: Offset(1.0, 1.0),
    shadowBlur: 1.0,
  ),
)
```

### CRT 모니터 스타일
```dart
PixelTextWidget(
  text: 'CRT MONITOR',
  artStyle: PixelArtStyle(
    pixelSize: 5.0,
    pixelColor: Color(0xFF00FF41), // CRT 녹색
    backgroundColor: Color(0xFF000000), // 검정 배경
    pixelSpacing: 0.5,
    enableShadow: true,
    shadowColor: Color(0xFF00FF41).withValues(alpha: 0.3),
    shadowOffset: Offset(0.5, 0.5),
    shadowBlur: 3.0,
    showGrid: true,
    gridColor: Color(0xFF00FF41).withValues(alpha: 0.1),
    gridLineWidth: 0.3,
  ),
)
```

### 레트로 아케이드 스타일
```dart
PixelTextWidget(
  text: 'ARCADE',
  artStyle: PixelArtStyle(
    pixelSize: 6.0,
    pixelColor: Color(0xFF00FFFF), // 네온 블루
    backgroundColor: Color(0xFF0F0F23), // 어두운 블루
    pixelSpacing: 1.5,
    enableShadow: true,
    shadowColor: Colors.black87,
    shadowOffset: Offset(2.0, 2.0),
    shadowBlur: 3.0,
  ),
)
```

### 반투명 스타일
```dart
PixelTextWidget(
  text: 'TRANSLUCENT',
  artStyle: PixelArtStyle(
    pixelSize: 4.0,
    pixelColor: Colors.black,
    backgroundColor: Colors.white,
    pixelOpacity: 0.6,
  ),
)
```

### 글래스 효과 스타일
```dart
PixelTextWidget(
  text: 'GLASS',
  artStyle: PixelArtStyle(
    pixelSize: 6.0,
    pixelColor: Colors.cyan,
    backgroundColor: Colors.blueGrey,
    pixelOpacity: 0.7,
    pixelSpacing: 1.0,
    enableShadow: true,
    shadowColor: Colors.black26,
    shadowOffset: Offset(1.5, 1.5),
    shadowBlur: 2.0,
  ),
)
```

### 홀로그램 효과 스타일
```dart
PixelTextWidget(
  text: 'HOLOGRAM',
  artStyle: PixelArtStyle(
    pixelSize: 5.0,
    pixelColor: Color(0xFF00FFFF), // 네온 블루
    backgroundColor: Colors.black,
    pixelOpacity: 0.8,
    pixelSpacing: 0.5,
    enableShadow: true,
    shadowColor: Color(0xFF00FFFF).withValues(alpha: 0.3),
    shadowOffset: Offset(1.0, 1.0),
    shadowBlur: 4.0,
    showGrid: true,
    gridColor: Color(0xFF00FFFF).withValues(alpha: 0.1),
    gridLineWidth: 0.2,
  ),
)
```

## 설정 옵션

### PixelFontConfig

폰트 설정을 관리하는 클래스입니다.

#### 속성

| 속성 | 타입 | 기본값 | 설명 |
|-----|------|-------|------|
| fontSize | double | 16.0 | 폰트 크기 |
| fontFamily | String | 'monospace' | 폰트 패밀리 |
| fontWeight | FontWeight | FontWeight.w100 | 폰트 굵기 |
| textColor | Color | Colors.black | 텍스트 색상 |
| backgroundColor | Color | Colors.transparent | 배경 색상 |
| threshold | int | 80 | 픽셀 변환 임계값 |
| useAntiAliasing | bool | false | 안티앨리어싱 사용 여부 |
| letterPixelWidth | int? | null | 글자당 픽셀 너비 (고정 크기) |
| letterPixelHeight | int? | null | 글자당 픽셀 높이 (고정 크기) |

#### 사용 예제

```dart
// 기본 설정
PixelFontConfig()

// 커스텀 설정
PixelFontConfig(
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
  threshold: 100,
  useAntiAliasing: true,
)

// 고정 크기 설정
PixelFontConfig(
  fontSize: 16.0,
  letterPixelWidth: 8,
  letterPixelHeight: 16,
  threshold: 70,
)
```

### PixelArtStyle

픽셀아트 스타일을 관리하는 클래스입니다.

#### 속성

- `pixelSize`: 픽셀 크기 (기본값: 4.0)
- `pixelColor`: 픽셀 색상
- `backgroundColor`: 배경 색상
- `pixelSpacing`: 픽셀 간격 (기본값: 0.0)
- `pixelOpacity`: 픽셀 불투명도 (기본값: 1.0)
- `showGrid`: 그리드 표시 여부
- `gridColor`: 그리드 색상
- `gridLineWidth`: 그리드 선 두께
- `enableShadow`: 그림자 효과 활성화
- `shadowColor`: 그림자 색상
- `shadowOffset`: 그림자 오프셋
- `shadowBlur`: 그림자 블러

#### 사용 예제

```dart
// 기본 스타일
PixelArtStyle()

// 커스텀 스타일
PixelArtStyle(
  pixelSize: 6.0,
  pixelColor: Colors.blue,
  backgroundColor: Colors.black,
  showGrid: true,
  enableShadow: true,
)
```

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
- 🎛️ 모든 설정 옵션 조절 (폰트 크기, 픽셀 크기, 불투명도, 그림자 등)
- 🎮 게임보이 LCD 스타일 데모 (도트 매트릭스 효과)
- 🔧 완전 커스터마이징 가능한 픽셀아트 생성
- 📱 고정 크기 폰트 옵션 (8x8, 8x16 등)
- 🌈 다양한 색상과 효과 옵션

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
