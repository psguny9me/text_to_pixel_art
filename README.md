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

Flutter용 텍스트를 픽셀아트로 변환하는 라이브러리입니다. 텍스트를 렌더링하여 픽셀 매트릭스로 변환하고, 다양한 스타일의 픽셀아트로 화면에 표시할 수 있습니다.

## 🚀 멀티플랫폼 지원

이 라이브러리는 **모든 Flutter 플랫폼**에서 작동합니다:

- ✅ **Android** - 안드로이드 앱
- ✅ **iOS** - iOS 앱  
- ✅ **Web** - 웹 브라우저
- ✅ **macOS** - macOS 데스크톱 앱
- ✅ **Windows** - Windows 데스크톱 앱
- ✅ **Linux** - Linux 데스크톱 앱

순수 Dart/Flutter 위젯을 사용하므로 네이티브 플러그인 없이 모든 플랫폼에서 동일하게 작동합니다.

## 특징

- 📝 텍스트를 픽셀아트로 변환
- 🎨 다양한 픽셀 스타일 지원 (크기, 색상, 그리드)
- 📏 여러 줄 텍스트 지원
- ⚙️ 폰트 설정 가능 (크기, 가족, 임계값)
- 🔧 완전히 커스터마이징 가능
- 🚀 간단한 사용법

## 설치

`pubspec.yaml` 파일에 다음을 추가하세요:

```yaml
dependencies:
  text_to_pixel_art: ^0.1.0
```

그리고 다음 명령어를 실행하세요:

```bash
flutter pub get
```

## 사용법

### 기본 사용법

```dart
import 'package:flutter/material.dart';
import 'package:text_to_pixel_art/text_to_pixel_art.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PixelText.create(
      text: 'Hello World!',
      pixelSize: 4.0,
      pixelColor: Colors.black,
    );
  }
}
```

### 다양한 크기 스타일

```dart
// 작은 크기
PixelText.small(
  text: 'Small Text',
  pixelColor: Colors.blue,
)

// 큰 크기
PixelText.large(
  text: 'Large Text',
  pixelColor: Colors.red,
  showGrid: true,
)
```

### 커스텀 설정

```dart
PixelTextWidget(
  text: 'Custom Text',
  fontConfig: PixelFontConfig(
    fontSize: 18.0,
    fontFamily: 'monospace',
    threshold: 100,
  ),
  artStyle: PixelArtStyle(
    pixelSize: 6.0,
    pixelColor: Colors.green,
    showGrid: true,
    gridColor: Colors.grey,
  ),
)
```

### 여러 줄 텍스트

```dart
PixelTextWidget.multiLine(
  text: 'Line 1\nLine 2\nLine 3',
  fontConfig: PixelFontConfig.small(),
  artStyle: PixelArtStyle.withGrid(),
)
```

## 📱 플랫폼별 실행 방법

### Android/iOS
```bash
flutter run
```

### 웹
```bash
flutter run -d web
# 또는 특정 브라우저
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

더 자세한 예제는 `example/` 디렉토리를 참조하세요.

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

버그 리포트나 기능 요청은 [GitHub Issues](https://github.com/your-username/text_to_pixel_art/issues)에 제출해 주세요.

## 지원

문의사항이 있으시면 [GitHub](https://github.com/your-username/text_to_pixel_art)를 방문해 주세요.
