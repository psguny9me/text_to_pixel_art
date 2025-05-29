import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'pixel_matrix.dart';
import 'pixel_font_config.dart';

/// 텍스트를 픽셀 매트릭스로 변환하는 컨버터
class TextToPixelConverter {
  /// 텍스트를 픽셀 매트릭스로 변환
  static Future<PixelMatrix> convertTextToPixelMatrix(
    String text,
    PixelFontConfig config,
  ) async {
    // 텍스트 렌더러 생성
    final ui.ParagraphBuilder paragraphBuilder = ui.ParagraphBuilder(
      ui.ParagraphStyle(
        textAlign: TextAlign.left,
        fontSize: config.fontSize,
        fontFamily: config.fontFamily,
        fontWeight: config.fontWeight,
      ),
    );

    // 텍스트 스타일 적용
    paragraphBuilder.pushStyle(
      ui.TextStyle(
        color: config.textColor,
        fontSize: config.fontSize,
        fontFamily: config.fontFamily,
        fontWeight: config.fontWeight,
      ),
    );

    paragraphBuilder.addText(text);
    final ui.Paragraph paragraph = paragraphBuilder.build();

    // 텍스트 크기 측정
    paragraph.layout(const ui.ParagraphConstraints(width: double.infinity));
    final double textWidth = paragraph.maxIntrinsicWidth;
    final double textHeight = paragraph.height;

    // 캔버스 크기 설정 (여백 추가)
    final int canvasWidth = (textWidth + 4).ceil();
    final int canvasHeight = (textHeight + 4).ceil();

    // 이미지로 렌더링
    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(recorder);

    // 배경색 설정
    if (config.backgroundColor != Colors.transparent) {
      final Paint backgroundPaint = Paint()..color = config.backgroundColor;
      canvas.drawRect(
        Rect.fromLTWH(0, 0, canvasWidth.toDouble(), canvasHeight.toDouble()),
        backgroundPaint,
      );
    }

    // 텍스트 그리기
    canvas.drawParagraph(paragraph, const Offset(2, 2));

    // Picture를 이미지로 변환
    final ui.Picture picture = recorder.endRecording();
    final ui.Image image = await picture.toImage(canvasWidth, canvasHeight);
    final ByteData? byteData = await image.toByteData(
      format: ui.ImageByteFormat.rawRgba,
    );

    if (byteData == null) {
      throw Exception('이미지 데이터를 생성할 수 없습니다.');
    }

    // ByteData를 Uint8List로 변환
    final Uint8List imageData = byteData.buffer.asUint8List();

    // 픽셀 매트릭스로 변환
    return PixelMatrix.fromImageData(
      imageData,
      canvasWidth,
      canvasHeight,
      threshold: config.threshold,
    );
  }

  /// 여러 줄 텍스트를 픽셀 매트릭스로 변환
  static Future<PixelMatrix> convertMultilineTextToPixelMatrix(
    List<String> lines,
    PixelFontConfig config,
  ) async {
    final List<PixelMatrix> lineMatrices = [];
    int maxWidth = 0;

    // 각 줄을 개별적으로 변환
    for (final String line in lines) {
      final PixelMatrix lineMatrix = await convertTextToPixelMatrix(
        line.isEmpty ? ' ' : line, // 빈 줄 처리
        config,
      );
      lineMatrices.add(lineMatrix);
      if (lineMatrix.width > maxWidth) {
        maxWidth = lineMatrix.width;
      }
    }

    // 전체 높이 계산
    final int totalHeight = lineMatrices.fold<int>(
      0,
      (int sum, PixelMatrix matrix) => sum + matrix.height,
    );

    // 결합된 매트릭스 생성
    final PixelMatrix combinedMatrix = PixelMatrix.empty(maxWidth, totalHeight);

    // 각 줄을 결합된 매트릭스에 복사
    int currentY = 0;
    for (final PixelMatrix lineMatrix in lineMatrices) {
      for (int y = 0; y < lineMatrix.height; y++) {
        for (int x = 0; x < lineMatrix.width; x++) {
          if (lineMatrix.getPixel(x, y)) {
            combinedMatrix.setPixel(x, currentY + y, true);
          }
        }
      }
      currentY += lineMatrix.height;
    }

    return combinedMatrix;
  }

  /// 텍스트 크기 측정
  static Size measureTextSize(String text, PixelFontConfig config) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: config.toTextStyle(),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    return textPainter.size;
  }
}
