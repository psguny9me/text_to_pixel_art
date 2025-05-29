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

  const PixelArtPainter({
    required this.pixelMatrix,
    this.pixelSize = 4.0,
    this.pixelColor = Colors.black,
    this.backgroundColor = Colors.transparent,
    this.showGrid = false,
    this.gridColor = Colors.grey,
    this.gridLineWidth = 0.5,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 배경 그리기
    if (backgroundColor != Colors.transparent) {
      final Paint backgroundPaint = Paint()..color = backgroundColor;
      canvas.drawRect(Offset.zero & size, backgroundPaint);
    }

    // 픽셀 페인트 설정
    final Paint pixelPaint = Paint()
      ..color = pixelColor
      ..style = PaintingStyle.fill;

    // 각 픽셀 그리기
    for (int y = 0; y < pixelMatrix.height; y++) {
      for (int x = 0; x < pixelMatrix.width; x++) {
        if (pixelMatrix.getPixel(x, y)) {
          final Rect pixelRect = Rect.fromLTWH(
            x * pixelSize,
            y * pixelSize,
            pixelSize,
            pixelSize,
          );
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
        gridLineWidth != oldDelegate.gridLineWidth;
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

  const PixelArtStyle({
    this.pixelSize = 4.0,
    this.pixelColor = Colors.black,
    this.backgroundColor = Colors.transparent,
    this.showGrid = false,
    this.gridColor = Colors.grey,
    this.gridLineWidth = 0.5,
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

  /// 스타일 복사
  PixelArtStyle copyWith({
    double? pixelSize,
    Color? pixelColor,
    Color? backgroundColor,
    bool? showGrid,
    Color? gridColor,
    double? gridLineWidth,
  }) {
    return PixelArtStyle(
      pixelSize: pixelSize ?? this.pixelSize,
      pixelColor: pixelColor ?? this.pixelColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      showGrid: showGrid ?? this.showGrid,
      gridColor: gridColor ?? this.gridColor,
      gridLineWidth: gridLineWidth ?? this.gridLineWidth,
    );
  }
}
