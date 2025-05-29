import 'dart:typed_data';

/// 픽셀 매트릭스를 나타내는 클래스
class PixelMatrix {
  final List<List<bool>> matrix;
  final int width;
  final int height;

  const PixelMatrix({
    required this.matrix,
    required this.width,
    required this.height,
  });

  /// 빈 매트릭스 생성
  factory PixelMatrix.empty(int width, int height) {
    final List<List<bool>> matrix = List.generate(
      height,
      (_) => List.generate(width, (_) => false),
    );
    return PixelMatrix(
      matrix: matrix,
      width: width,
      height: height,
    );
  }

  /// 이미지 데이터에서 픽셀 매트릭스 생성
  factory PixelMatrix.fromImageData(
    Uint8List imageData,
    int width,
    int height, {
    int threshold = 128,
  }) {
    final List<List<bool>> matrix = [];

    for (int y = 0; y < height; y++) {
      final List<bool> row = [];
      for (int x = 0; x < width; x++) {
        final int pixelIndex = (y * width + x) * 4; // RGBA
        if (pixelIndex + 3 < imageData.length) {
          final int alpha = imageData[pixelIndex + 3];
          final int red = imageData[pixelIndex];
          final int green = imageData[pixelIndex + 1];
          final int blue = imageData[pixelIndex + 2];

          // 밝기 계산 (그레이스케일 변환)
          final double brightness =
              (red * 0.299) + (green * 0.587) + (blue * 0.114);

          // 임계값보다 어두우면 픽셀이 있다고 판단
          row.add(alpha > threshold && brightness < threshold);
        } else {
          row.add(false);
        }
      }
      matrix.add(row);
    }

    return PixelMatrix(
      matrix: matrix,
      width: width,
      height: height,
    );
  }

  /// 특정 위치의 픽셀 값 반환
  bool getPixel(int x, int y) {
    if (x < 0 || x >= width || y < 0 || y >= height) {
      return false;
    }
    return matrix[y][x];
  }

  /// 특정 위치의 픽셀 값 설정
  void setPixel(int x, int y, bool value) {
    if (x >= 0 && x < width && y >= 0 && y < height) {
      matrix[y][x] = value;
    }
  }

  /// 매트릭스를 문자열로 변환 (디버깅용)
  String toDebugString() {
    final StringBuffer buffer = StringBuffer();
    for (final List<bool> row in matrix) {
      for (final bool pixel in row) {
        buffer.write(pixel ? '█' : '░');
      }
      buffer.writeln();
    }
    return buffer.toString();
  }

  /// 매트릭스 복사
  PixelMatrix copy() {
    final List<List<bool>> newMatrix =
        matrix.map((List<bool> row) => List<bool>.from(row)).toList();
    return PixelMatrix(
      matrix: newMatrix,
      width: width,
      height: height,
    );
  }

  /// 매트릭스 크기 조정
  PixelMatrix resize(int newWidth, int newHeight) {
    final PixelMatrix resized = PixelMatrix.empty(newWidth, newHeight);

    for (int y = 0; y < newHeight; y++) {
      for (int x = 0; x < newWidth; x++) {
        final int originalX = (x * width) ~/ newWidth;
        final int originalY = (y * height) ~/ newHeight;
        resized.setPixel(x, y, getPixel(originalX, originalY));
      }
    }

    return resized;
  }
}
