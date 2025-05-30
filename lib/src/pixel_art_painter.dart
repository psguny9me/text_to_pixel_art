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
