import 'package:flutter/material.dart';
import 'pixel_matrix.dart';

/// 픽셀아트를 그리는 커스텀 페인터
class PixelArtPainter extends CustomPainter {
  final PixelMatrix pixelMatrix;
  final double pixelSize;
  final Color pixelColor;
  final Color backgroundColor;
  final bool showGrid;
  final Color gridColor;
  final double gridLineWidth;
  final double pixelSpacing; // 픽셀 간격
  final bool enableShadow; // 그림자 효과 활성화
  final Color shadowColor; // 그림자 색상
  final Offset shadowOffset; // 그림자 오프셋
  final double shadowBlur; // 그림자 블러
  final double pixelOpacity; // 픽셀 불투명도 (0.0 ~ 1.0)

  const PixelArtPainter({
    required this.pixelMatrix,
    this.pixelSize = 4.0,
    this.pixelColor = Colors.black,
    this.backgroundColor = Colors.transparent,
    this.showGrid = false,
    this.gridColor = Colors.grey,
    this.gridLineWidth = 0.5,
    this.pixelSpacing = 0.0,
    this.enableShadow = false,
    this.shadowColor = Colors.black54,
    this.shadowOffset = const Offset(1.0, 1.0),
    this.shadowBlur = 2.0,
    this.pixelOpacity = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 배경 그리기
    if (backgroundColor != Colors.transparent) {
      final Paint backgroundPaint = Paint()..color = backgroundColor;
      canvas.drawRect(Offset.zero & size, backgroundPaint);
    }

    // 픽셀 페인트 설정 (불투명도 적용)
    final Paint pixelPaint = Paint()
      ..color = pixelColor.withValues(alpha: pixelOpacity)
      ..style = PaintingStyle.fill;

    // 그림자 페인트 설정
    Paint? shadowPaint;
    if (enableShadow) {
      shadowPaint = Paint()
        ..color = shadowColor
        ..style = PaintingStyle.fill
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, shadowBlur);
    }

    // 실제 픽셀 크기 (간격 고려)
    final double actualPixelSize = pixelSize - pixelSpacing;

    // 각 픽셀 그리기
    for (int y = 0; y < pixelMatrix.height; y++) {
      for (int x = 0; x < pixelMatrix.width; x++) {
        if (pixelMatrix.getPixel(x, y)) {
          final double pixelX = x * pixelSize + (pixelSpacing / 2);
          final double pixelY = y * pixelSize + (pixelSpacing / 2);

          final Rect pixelRect = Rect.fromLTWH(
            pixelX,
            pixelY,
            actualPixelSize,
            actualPixelSize,
          );

          // 그림자 그리기 (먼저)
          if (enableShadow && shadowPaint != null) {
            final Rect shadowRect = Rect.fromLTWH(
              pixelX + shadowOffset.dx,
              pixelY + shadowOffset.dy,
              actualPixelSize,
              actualPixelSize,
            );
            canvas.drawRect(shadowRect, shadowPaint);
          }

          // 픽셀 그리기 (불투명도 적용됨)
          canvas.drawRect(pixelRect, pixelPaint);
        }
      }
    }

    // 그리드 그리기 (옵션)
    if (showGrid) {
      _drawGrid(canvas, size);
    }
  }

  /// 그리드 그리기
  void _drawGrid(Canvas canvas, Size size) {
    final Paint gridPaint = Paint()
      ..color = gridColor
      ..strokeWidth = gridLineWidth
      ..style = PaintingStyle.stroke;

    // 세로 선 그리기
    for (int x = 0; x <= pixelMatrix.width; x++) {
      final double xPos = x * pixelSize;
      canvas.drawLine(
        Offset(xPos, 0),
        Offset(xPos, pixelMatrix.height * pixelSize),
        gridPaint,
      );
    }

    // 가로 선 그리기
    for (int y = 0; y <= pixelMatrix.height; y++) {
      final double yPos = y * pixelSize;
      canvas.drawLine(
        Offset(0, yPos),
        Offset(pixelMatrix.width * pixelSize, yPos),
        gridPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant PixelArtPainter oldDelegate) {
    return pixelMatrix != oldDelegate.pixelMatrix ||
        pixelSize != oldDelegate.pixelSize ||
        pixelColor != oldDelegate.pixelColor ||
        backgroundColor != oldDelegate.backgroundColor ||
        showGrid != oldDelegate.showGrid ||
        gridColor != oldDelegate.gridColor ||
        gridLineWidth != oldDelegate.gridLineWidth ||
        pixelSpacing != oldDelegate.pixelSpacing ||
        enableShadow != oldDelegate.enableShadow ||
        shadowColor != oldDelegate.shadowColor ||
        shadowOffset != oldDelegate.shadowOffset ||
        shadowBlur != oldDelegate.shadowBlur ||
        pixelOpacity != oldDelegate.pixelOpacity;
  }

  /// 픽셀아트의 크기를 반환
  Size getSize(Size size) {
    return Size(
      pixelMatrix.width * pixelSize,
      pixelMatrix.height * pixelSize,
    );
  }
}

/// 레트로 색상 팔레트
class RetroColors {
  // 80년대 네온 컬러
  static const Color neonPink = Color(0xFFFF10F0);
  static const Color neonBlue = Color(0xFF00FFFF);
  static const Color neonGreen = Color(0xFF39FF14);
  static const Color neonYellow = Color(0xFFFFFF00);
  static const Color neonOrange = Color(0xFFFF6600);
  static const Color neonPurple = Color(0xFF9D00FF);

  // 80년대 배경 컬러
  static const Color darkPurple = Color(0xFF2D1B69);
  static const Color darkBlue = Color(0xFF0F0F23);
  static const Color darkTeal = Color(0xFF1A2332);
  static const Color darkMagenta = Color(0xFF4A0E4E);

  // 게임보이 컬러
  static const Color gameboyGreen = Color(0xFF8BAC0F);
  static const Color gameboyDarkGreen = Color(0xFF306230);
  static const Color gameboyLightGreen = Color(0xFF9BBD0F);
  static const Color gameboyBackground = Color(0xFF0F380F);

  // CRT 모니터 컬러
  static const Color crtGreen = Color(0xFF00FF41);
  static const Color crtAmber = Color(0xFFFFB000);
  static const Color crtWhite = Color(0xFFFFFFFF);
  static const Color crtBackground = Color(0xFF000000);
}

/// 픽셀아트 스타일 설정
class PixelArtStyle {
  final double pixelSize;
  final Color pixelColor;
  final Color backgroundColor;
  final bool showGrid;
  final Color gridColor;
  final double gridLineWidth;
  final double pixelSpacing; // 픽셀 간격
  final bool enableShadow; // 그림자 효과
  final Color shadowColor; // 그림자 색상
  final Offset shadowOffset; // 그림자 오프셋
  final double shadowBlur; // 그림자 블러
  final double pixelOpacity; // 픽셀 불투명도 (0.0 ~ 1.0)

  const PixelArtStyle({
    this.pixelSize = 4.0,
    this.pixelColor = Colors.black,
    this.backgroundColor = Colors.transparent,
    this.showGrid = false,
    this.gridColor = Colors.grey,
    this.gridLineWidth = 0.5,
    this.pixelSpacing = 0.0,
    this.enableShadow = false,
    this.shadowColor = Colors.black54,
    this.shadowOffset = const Offset(1.0, 1.0),
    this.shadowBlur = 2.0,
    this.pixelOpacity = 1.0,
  });

  /// 기본 픽셀아트 스타일
  factory PixelArtStyle.defaultStyle() {
    return const PixelArtStyle();
  }

  /// 큰 픽셀 스타일
  factory PixelArtStyle.large({
    Color pixelColor = Colors.black,
    Color backgroundColor = Colors.transparent,
  }) {
    return PixelArtStyle(
      pixelSize: 8.0,
      pixelColor: pixelColor,
      backgroundColor: backgroundColor,
    );
  }

  /// 작은 픽셀 스타일
  factory PixelArtStyle.small({
    Color pixelColor = Colors.black,
    Color backgroundColor = Colors.transparent,
  }) {
    return PixelArtStyle(
      pixelSize: 2.0,
      pixelColor: pixelColor,
      backgroundColor: backgroundColor,
    );
  }

  /// 그리드가 있는 픽셀아트 스타일
  factory PixelArtStyle.withGrid({
    double pixelSize = 4.0,
    Color pixelColor = Colors.black,
    Color backgroundColor = Colors.transparent,
    Color gridColor = Colors.grey,
    double gridLineWidth = 0.5,
  }) {
    return PixelArtStyle(
      pixelSize: pixelSize,
      pixelColor: pixelColor,
      backgroundColor: backgroundColor,
      showGrid: true,
      gridColor: gridColor,
      gridLineWidth: gridLineWidth,
    );
  }

  /// 80년대 네온 스타일
  factory PixelArtStyle.neon80s({
    double pixelSize = 6.0,
    Color pixelColor = RetroColors.neonPink,
    Color backgroundColor = RetroColors.darkPurple,
  }) {
    return PixelArtStyle(
      pixelSize: pixelSize,
      pixelColor: pixelColor,
      backgroundColor: backgroundColor,
      pixelSpacing: 1.0,
      enableShadow: true,
      shadowColor: pixelColor.withValues(alpha: 0.5),
      shadowOffset: const Offset(2.0, 2.0),
      shadowBlur: 4.0,
    );
  }

  /// 게임보이 스타일
  factory PixelArtStyle.gameboy({
    double pixelSize = 4.0,
  }) {
    return PixelArtStyle(
      pixelSize: pixelSize,
      pixelColor: RetroColors.gameboyGreen,
      backgroundColor: RetroColors.gameboyBackground,
      pixelSpacing: 0.5,
      enableShadow: true,
      shadowColor: RetroColors.gameboyDarkGreen,
      shadowOffset: const Offset(1.0, 1.0),
      shadowBlur: 1.0,
    );
  }

  /// CRT 모니터 스타일
  factory PixelArtStyle.crtMonitor({
    double pixelSize = 5.0,
    Color pixelColor = RetroColors.crtGreen,
  }) {
    return PixelArtStyle(
      pixelSize: pixelSize,
      pixelColor: pixelColor,
      backgroundColor: RetroColors.crtBackground,
      pixelSpacing: 0.5,
      enableShadow: true,
      shadowColor: pixelColor.withValues(alpha: 0.3),
      shadowOffset: const Offset(0.5, 0.5),
      shadowBlur: 3.0,
      showGrid: true,
      gridColor: pixelColor.withValues(alpha: 0.1),
      gridLineWidth: 0.3,
    );
  }

  /// 레트로 아케이드 스타일
  factory PixelArtStyle.retroArcade({
    double pixelSize = 6.0,
    Color pixelColor = RetroColors.neonBlue,
  }) {
    return PixelArtStyle(
      pixelSize: pixelSize,
      pixelColor: pixelColor,
      backgroundColor: RetroColors.darkBlue,
      pixelSpacing: 1.5,
      enableShadow: true,
      shadowColor: Colors.black87,
      shadowOffset: const Offset(2.0, 2.0),
      shadowBlur: 3.0,
    );
  }

  /// 픽셀 간격이 있는 스타일
  factory PixelArtStyle.withSpacing({
    double pixelSize = 4.0,
    double pixelSpacing = 1.0,
    Color pixelColor = Colors.black,
    Color backgroundColor = Colors.white,
  }) {
    return PixelArtStyle(
      pixelSize: pixelSize,
      pixelColor: pixelColor,
      backgroundColor: backgroundColor,
      pixelSpacing: pixelSpacing,
    );
  }

  /// 그림자 효과가 있는 스타일
  factory PixelArtStyle.withShadow({
    double pixelSize = 4.0,
    Color pixelColor = Colors.black,
    Color backgroundColor = Colors.transparent,
    Color shadowColor = Colors.black54,
    Offset shadowOffset = const Offset(2.0, 2.0),
    double shadowBlur = 3.0,
  }) {
    return PixelArtStyle(
      pixelSize: pixelSize,
      pixelColor: pixelColor,
      backgroundColor: backgroundColor,
      enableShadow: true,
      shadowColor: shadowColor,
      shadowOffset: shadowOffset,
      shadowBlur: shadowBlur,
    );
  }

  /// 반투명 픽셀 스타일
  factory PixelArtStyle.translucent({
    double pixelSize = 4.0,
    Color pixelColor = Colors.black,
    Color backgroundColor = Colors.white,
    double pixelOpacity = 0.6,
  }) {
    return PixelArtStyle(
      pixelSize: pixelSize,
      pixelColor: pixelColor,
      backgroundColor: backgroundColor,
      pixelOpacity: pixelOpacity,
    );
  }

  /// 글래스 효과 스타일 (반투명 + 그림자)
  factory PixelArtStyle.glass({
    double pixelSize = 6.0,
    Color pixelColor = Colors.cyan,
    Color backgroundColor = Colors.blueGrey,
    double pixelOpacity = 0.7,
  }) {
    return PixelArtStyle(
      pixelSize: pixelSize,
      pixelColor: pixelColor,
      backgroundColor: backgroundColor,
      pixelOpacity: pixelOpacity,
      pixelSpacing: 1.0,
      enableShadow: true,
      shadowColor: Colors.black26,
      shadowOffset: const Offset(1.5, 1.5),
      shadowBlur: 2.0,
    );
  }

  /// 홀로그램 효과 스타일
  factory PixelArtStyle.hologram({
    double pixelSize = 5.0,
    Color pixelColor = RetroColors.neonBlue,
    Color backgroundColor = Colors.black,
    double pixelOpacity = 0.8,
  }) {
    return PixelArtStyle(
      pixelSize: pixelSize,
      pixelColor: pixelColor,
      backgroundColor: backgroundColor,
      pixelOpacity: pixelOpacity,
      pixelSpacing: 0.5,
      enableShadow: true,
      shadowColor: pixelColor.withValues(alpha: 0.3),
      shadowOffset: const Offset(1.0, 1.0),
      shadowBlur: 4.0,
      showGrid: true,
      gridColor: pixelColor.withValues(alpha: 0.1),
      gridLineWidth: 0.2,
    );
  }

  /// 스타일 복사
  PixelArtStyle copyWith({
    double? pixelSize,
    Color? pixelColor,
    Color? backgroundColor,
    bool? showGrid,
    Color? gridColor,
    double? gridLineWidth,
    double? pixelSpacing,
    bool? enableShadow,
    Color? shadowColor,
    Offset? shadowOffset,
    double? shadowBlur,
    double? pixelOpacity,
  }) {
    return PixelArtStyle(
      pixelSize: pixelSize ?? this.pixelSize,
      pixelColor: pixelColor ?? this.pixelColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      showGrid: showGrid ?? this.showGrid,
      gridColor: gridColor ?? this.gridColor,
      gridLineWidth: gridLineWidth ?? this.gridLineWidth,
      pixelSpacing: pixelSpacing ?? this.pixelSpacing,
      enableShadow: enableShadow ?? this.enableShadow,
      shadowColor: shadowColor ?? this.shadowColor,
      shadowOffset: shadowOffset ?? this.shadowOffset,
      shadowBlur: shadowBlur ?? this.shadowBlur,
      pixelOpacity: pixelOpacity ?? this.pixelOpacity,
    );
  }
}
