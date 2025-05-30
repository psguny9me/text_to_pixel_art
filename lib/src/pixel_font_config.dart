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
  final int? letterPixelWidth; // 글자당 픽셀 너비 (null이면 자동)
  final int? letterPixelHeight; // 글자당 픽셀 높이 (null이면 자동)

  const PixelFontConfig({
    this.fontSize = 16.0,
    this.fontFamily = 'monospace',
    this.fontWeight = FontWeight.w100,
    this.textColor = Colors.black,
    this.backgroundColor = Colors.transparent,
    this.threshold = 80,
    this.useAntiAliasing = false,
    this.letterPixelWidth,
    this.letterPixelHeight,
  });

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
    int? letterPixelWidth,
    int? letterPixelHeight,
  }) {
    return PixelFontConfig(
      fontSize: fontSize ?? this.fontSize,
      fontFamily: fontFamily ?? this.fontFamily,
      fontWeight: fontWeight ?? this.fontWeight,
      textColor: textColor ?? this.textColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      threshold: threshold ?? this.threshold,
      useAntiAliasing: useAntiAliasing ?? this.useAntiAliasing,
      letterPixelWidth: letterPixelWidth ?? this.letterPixelWidth,
      letterPixelHeight: letterPixelHeight ?? this.letterPixelHeight,
    );
  }
}
