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
    // 고정 크기가 지정된 경우 고정 크기 변환 사용
    if (config.letterPixelWidth != null && config.letterPixelHeight != null) {
      return _convertTextToFixedSizePixelMatrix(text, config);
    }

    // 기존 동적 크기 변환
    return _convertTextToDynamicSizePixelMatrix(text, config);
  }

  /// 고정 크기로 텍스트를 픽셀 매트릭스로 변환
  static Future<PixelMatrix> _convertTextToFixedSizePixelMatrix(
    String text,
    PixelFontConfig config,
  ) async {
    final int letterWidth = config.letterPixelWidth!;
    final int letterHeight = config.letterPixelHeight!;
    final int totalWidth = text.length * letterWidth;

    // 전체 매트릭스 생성
    final PixelMatrix totalMatrix = PixelMatrix.empty(totalWidth, letterHeight);

    // 각 글자를 개별적으로 처리
    for (int i = 0; i < text.length; i++) {
      final String char = text[i];
      if (char == ' ') {
        // 공백은 빈 공간으로 처리
        continue;
      }

      // 개별 글자를 렌더링
      final PixelMatrix charMatrix = await _convertSingleCharToFixedSize(
        char,
        config,
        letterWidth,
        letterHeight,
      );

      // 전체 매트릭스에 복사
      final int offsetX = i * letterWidth;
      for (int y = 0; y < letterHeight; y++) {
        for (int x = 0; x < letterWidth; x++) {
          if (x < charMatrix.width && y < charMatrix.height) {
            final bool pixel = charMatrix.getPixel(x, y);
            totalMatrix.setPixel(offsetX + x, y, pixel);
          }
        }
      }
    }

    return totalMatrix;
  }

  /// 단일 글자를 고정 크기로 변환
  static Future<PixelMatrix> _convertSingleCharToFixedSize(
    String char,
    PixelFontConfig config,
    int targetWidth,
    int targetHeight,
  ) async {
    // 매우 큰 크기로 렌더링 (디테일 확보)
    final int renderSize = targetWidth * 16; // 8x8 → 128x128

    // 큰 크기로 렌더링
    final PixelMatrix originalMatrix = await _convertCharWithoutMargin(
      char,
      config,
      renderSize,
    );

    // 실제 픽셀이 있는 영역만 추출 (여백 완전 제거)
    final PixelMatrix croppedMatrix = _cropToContent(originalMatrix);

    // 8x8로 리사이즈 (여백 없는 상태에서)
    return _resizeToTarget(croppedMatrix, targetWidth, targetHeight);
  }

  /// 여백 없이 글자 렌더링
  static Future<PixelMatrix> _convertCharWithoutMargin(
    String char,
    PixelFontConfig config,
    int size,
  ) async {
    // 큰 폰트 크기로 렌더링
    final double largeFontSize = size * 0.8; // 캔버스의 80% 크기

    final ui.ParagraphBuilder paragraphBuilder = ui.ParagraphBuilder(
      ui.ParagraphStyle(
        textAlign: TextAlign.center,
        fontSize: largeFontSize,
        fontFamily: config.fontFamily,
        fontWeight: config.fontWeight,
      ),
    );

    paragraphBuilder.pushStyle(
      ui.TextStyle(
        color: config.textColor,
        fontSize: largeFontSize,
        fontFamily: config.fontFamily,
        fontWeight: config.fontWeight,
      ),
    );

    paragraphBuilder.addText(char);
    final ui.Paragraph paragraph = paragraphBuilder.build();

    // 텍스트 크기 측정
    paragraph.layout(ui.ParagraphConstraints(width: size.toDouble()));

    // 정사각형 캔버스에 중앙 정렬로 렌더링
    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(recorder);

    // 배경색 설정
    if (config.backgroundColor != Colors.transparent) {
      final Paint backgroundPaint = Paint()..color = config.backgroundColor;
      canvas.drawRect(
        Rect.fromLTWH(0, 0, size.toDouble(), size.toDouble()),
        backgroundPaint,
      );
    }

    // 텍스트를 중앙에 그리기
    final double offsetX = (size - paragraph.maxIntrinsicWidth) / 2;
    final double offsetY = (size - paragraph.height) / 2;
    canvas.drawParagraph(paragraph, Offset(offsetX, offsetY));

    // Picture를 이미지로 변환
    final ui.Picture picture = recorder.endRecording();
    final ui.Image image = await picture.toImage(size, size);
    final ByteData? byteData = await image.toByteData(
      format: ui.ImageByteFormat.rawRgba,
    );

    if (byteData == null) {
      throw Exception('이미지 데이터를 생성할 수 없습니다.');
    }

    final Uint8List imageData = byteData.buffer.asUint8List();

    return PixelMatrix.fromImageData(
      imageData,
      size,
      size,
      threshold: config.threshold,
    );
  }

  /// 매트릭스를 지정된 크기로 다운샘플링
  static PixelMatrix _downsampleMatrix(
    PixelMatrix source,
    int targetWidth,
    int targetHeight,
  ) {
    final PixelMatrix target = PixelMatrix.empty(targetWidth, targetHeight);

    final double scaleX = source.width / targetWidth;
    final double scaleY = source.height / targetHeight;

    for (int y = 0; y < targetHeight; y++) {
      for (int x = 0; x < targetWidth; x++) {
        // 블록 영역의 픽셀 밀도 계산
        final int startX = (x * scaleX).floor();
        final int endX = ((x + 1) * scaleX).ceil().clamp(0, source.width);
        final int startY = (y * scaleY).floor();
        final int endY = ((y + 1) * scaleY).ceil().clamp(0, source.height);

        int pixelCount = 0;
        int totalPixels = 0;

        for (int sy = startY; sy < endY; sy++) {
          for (int sx = startX; sx < endX; sx++) {
            if (source.getPixel(sx, sy)) {
              pixelCount++;
            }
            totalPixels++;
          }
        }

        // 픽셀 밀도가 30% 이상이면 픽셀 설정
        final bool shouldSetPixel =
            totalPixels > 0 && (pixelCount / totalPixels) > 0.3;
        target.setPixel(x, y, shouldSetPixel);
      }
    }

    return target;
  }

  /// 동적 크기로 텍스트를 픽셀 매트릭스로 변환 (기존 방식)
  static Future<PixelMatrix> _convertTextToDynamicSizePixelMatrix(
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

  /// 실제 픽셀이 있는 영역만 추출 (여백 완전 제거)
  static PixelMatrix _cropToContent(PixelMatrix source) {
    int minX = source.width;
    int maxX = -1;
    int minY = source.height;
    int maxY = -1;

    // 실제 픽셀이 있는 최소/최대 좌표 찾기
    for (int y = 0; y < source.height; y++) {
      for (int x = 0; x < source.width; x++) {
        if (source.getPixel(x, y)) {
          if (x < minX) minX = x;
          if (x > maxX) maxX = x;
          if (y < minY) minY = y;
          if (y > maxY) maxY = y;
        }
      }
    }

    // 픽셀이 하나도 없는 경우 (공백 등)
    if (maxX == -1) {
      return PixelMatrix.empty(1, 1);
    }

    // 실제 컨텐츠 영역 크기 계산
    final int contentWidth = maxX - minX + 1;
    final int contentHeight = maxY - minY + 1;

    // 크롭된 매트릭스 생성
    final PixelMatrix cropped = PixelMatrix.empty(contentWidth, contentHeight);

    for (int y = 0; y < contentHeight; y++) {
      for (int x = 0; x < contentWidth; x++) {
        final bool pixel = source.getPixel(minX + x, minY + y);
        cropped.setPixel(x, y, pixel);
      }
    }

    return cropped;
  }

  /// 여백 없이 타겟 크기로 리사이즈 (aspect ratio 유지하면서 중앙 배치)
  static PixelMatrix _resizeToTarget(
    PixelMatrix source,
    int targetWidth,
    int targetHeight,
  ) {
    final PixelMatrix target = PixelMatrix.empty(targetWidth, targetHeight);

    if (source.width == 0 || source.height == 0) {
      return target; // 빈 매트릭스 반환
    }

    // 8x8처럼 매우 작은 크기의 경우 stretch 모드 사용
    if (targetWidth <= 8 && targetHeight <= 8) {
      return _resizeToTargetStretch(source, targetWidth, targetHeight);
    }

    // aspect ratio 계산하여 최적 크기 결정
    final double scaleX = targetWidth / source.width;
    final double scaleY = targetHeight / source.height;
    final double scale = scaleX < scaleY ? scaleX : scaleY;

    final int scaledWidth = (source.width * scale).round();
    final int scaledHeight = (source.height * scale).round();

    // 중앙 배치를 위한 오프셋 계산
    final int offsetX = (targetWidth - scaledWidth) ~/ 2;
    final int offsetY = (targetHeight - scaledHeight) ~/ 2;

    // 스케일링하여 중앙에 배치
    for (int ty = 0; ty < scaledHeight; ty++) {
      for (int tx = 0; tx < scaledWidth; tx++) {
        final int sourceX = (tx / scale).round();
        final int sourceY = (ty / scale).round();

        if (sourceX < source.width && sourceY < source.height) {
          final bool pixel = source.getPixel(sourceX, sourceY);
          final int targetX = offsetX + tx;
          final int targetY = offsetY + ty;

          if (targetX >= 0 &&
              targetX < targetWidth &&
              targetY >= 0 &&
              targetY < targetHeight) {
            target.setPixel(targetX, targetY, pixel);
          }
        }
      }
    }

    return target;
  }

  /// aspect ratio를 무시하고 전체 영역에 맞춰 늘리기 (stretch 모드)
  static PixelMatrix _resizeToTargetStretch(
    PixelMatrix source,
    int targetWidth,
    int targetHeight,
  ) {
    final PixelMatrix target = PixelMatrix.empty(targetWidth, targetHeight);

    if (source.width == 0 || source.height == 0) {
      return target;
    }

    final double scaleX = targetWidth / source.width;
    final double scaleY = targetHeight / source.height;

    // 각 타겟 픽셀에 대해 소스 영역의 픽셀 밀도 계산
    for (int ty = 0; ty < targetHeight; ty++) {
      for (int tx = 0; tx < targetWidth; tx++) {
        final double sourceStartX = tx / scaleX;
        final double sourceEndX = (tx + 1) / scaleX;
        final double sourceStartY = ty / scaleY;
        final double sourceEndY = (ty + 1) / scaleY;

        int pixelCount = 0;
        int totalSamples = 0;

        // 서브픽셀 샘플링
        final int samples = 3; // 3x3 서브픽셀 샘플링
        for (int sy = 0; sy < samples; sy++) {
          for (int sx = 0; sx < samples; sx++) {
            final double sampleX = sourceStartX +
                (sourceEndX - sourceStartX) * (sx + 0.5) / samples;
            final double sampleY = sourceStartY +
                (sourceEndY - sourceStartY) * (sy + 0.5) / samples;

            final int sourceX = sampleX.floor();
            final int sourceY = sampleY.floor();

            if (sourceX >= 0 &&
                sourceX < source.width &&
                sourceY >= 0 &&
                sourceY < source.height) {
              if (source.getPixel(sourceX, sourceY)) {
                pixelCount++;
              }
              totalSamples++;
            }
          }
        }

        // 픽셀 밀도가 33% 이상이면 픽셀 설정
        if (totalSamples > 0 && (pixelCount / totalSamples) > 0.33) {
          target.setPixel(tx, ty, true);
        }
      }
    }

    return target;
  }
}
