import 'package:flutter/material.dart';

/// 픽셀 폰트 설정을 관리하는 클래스
class PixelFontConfig {
  final double fontSize;
  final String fontFamily;
  final FontWeight fontWeight;
  final Color textColor;
  final Color backgroundColor;
  final int threshold;
  final bool useAntiAliasing;

  const PixelFontConfig({
    this.fontSize = 16.0,
    this.fontFamily = 'monospace',
    this.fontWeight = FontWeight.normal,
    this.textColor = Colors.black,
    this.backgroundColor = Colors.transparent,
    this.threshold = 128,
    this.useAntiAliasing = false,
  });

  /// 기본 모노스페이스 폰트 설정
  factory PixelFontConfig.monospace({
    double fontSize = 16.0,
    Color textColor = Colors.black,
    Color backgroundColor = Colors.transparent,
    int threshold = 128,
  }) {
    return PixelFontConfig(
      fontSize: fontSize,
      fontFamily: 'monospace',
      fontWeight: FontWeight.normal,
      textColor: textColor,
      backgroundColor: backgroundColor,
      threshold: threshold,
      useAntiAliasing: false,
    );
  }

  /// 작은 크기 픽셀 폰트 설정
  factory PixelFontConfig.small({
    Color textColor = Colors.black,
    Color backgroundColor = Colors.transparent,
    int threshold = 128,
  }) {
    return PixelFontConfig(
      fontSize: 12.0,
      fontFamily: 'monospace',
      fontWeight: FontWeight.bold,
      textColor: textColor,
      backgroundColor: backgroundColor,
      threshold: threshold,
      useAntiAliasing: false,
    );
  }

  /// 큰 크기 픽셀 폰트 설정
  factory PixelFontConfig.large({
    Color textColor = Colors.black,
    Color backgroundColor = Colors.transparent,
    int threshold = 128,
  }) {
    return PixelFontConfig(
      fontSize: 24.0,
      fontFamily: 'monospace',
      fontWeight: FontWeight.bold,
      textColor: textColor,
      backgroundColor: backgroundColor,
      threshold: threshold,
      useAntiAliasing: false,
    );
  }

  /// TextStyle로 변환
  TextStyle toTextStyle() {
    return TextStyle(
      fontSize: fontSize,
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      color: textColor,
      backgroundColor: backgroundColor,
    );
  }

  /// 설정 복사
  PixelFontConfig copyWith({
    double? fontSize,
    String? fontFamily,
    FontWeight? fontWeight,
    Color? textColor,
    Color? backgroundColor,
    int? threshold,
    bool? useAntiAliasing,
  }) {
    return PixelFontConfig(
      fontSize: fontSize ?? this.fontSize,
      fontFamily: fontFamily ?? this.fontFamily,
      fontWeight: fontWeight ?? this.fontWeight,
      textColor: textColor ?? this.textColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      threshold: threshold ?? this.threshold,
      useAntiAliasing: useAntiAliasing ?? this.useAntiAliasing,
    );
  }
}
