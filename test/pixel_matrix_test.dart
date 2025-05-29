import 'package:flutter_test/flutter_test.dart';
import 'package:text_to_pixel_art/text_to_pixel_art.dart';
import 'dart:typed_data';

void main() {
  group('PixelMatrix Tests', () {
    test('should create empty matrix with correct dimensions', () {
      // Arrange
      const int expectedWidth = 10;
      const int expectedHeight = 8;

      // Act
      final PixelMatrix actualMatrix =
          PixelMatrix.empty(expectedWidth, expectedHeight);

      // Assert
      expect(actualMatrix.width, equals(expectedWidth));
      expect(actualMatrix.height, equals(expectedHeight));

      // Check that all pixels are false (empty)
      for (int y = 0; y < expectedHeight; y++) {
        for (int x = 0; x < expectedWidth; x++) {
          expect(actualMatrix.getPixel(x, y), isFalse);
        }
      }
    });

    test('should set and get pixel values correctly', () {
      // Arrange
      final PixelMatrix actualMatrix = PixelMatrix.empty(5, 5);

      // Act
      actualMatrix.setPixel(2, 3, true);
      actualMatrix.setPixel(0, 0, true);

      // Assert
      expect(actualMatrix.getPixel(2, 3), isTrue);
      expect(actualMatrix.getPixel(0, 0), isTrue);
      expect(actualMatrix.getPixel(1, 1), isFalse);
    });

    test('should handle out of bounds access gracefully', () {
      // Arrange
      final PixelMatrix actualMatrix = PixelMatrix.empty(3, 3);

      // Act & Assert
      expect(actualMatrix.getPixel(-1, 0), isFalse);
      expect(actualMatrix.getPixel(0, -1), isFalse);
      expect(actualMatrix.getPixel(3, 0), isFalse);
      expect(actualMatrix.getPixel(0, 3), isFalse);

      // setPixel should not throw errors for out of bounds
      expect(() => actualMatrix.setPixel(-1, 0, true), returnsNormally);
      expect(() => actualMatrix.setPixel(3, 3, true), returnsNormally);
    });

    test('should create matrix from image data correctly', () {
      // Arrange
      final Uint8List mockImageData = Uint8List.fromList([
        // First pixel: white (should be false)
        255, 255, 255, 255,
        // Second pixel: black (should be true)
        0, 0, 0, 255,
      ]);
      const int width = 2;
      const int height = 1;
      const int threshold = 128;

      // Act
      final PixelMatrix actualMatrix = PixelMatrix.fromImageData(
        mockImageData,
        width,
        height,
        threshold: threshold,
      );

      // Assert
      expect(actualMatrix.width, equals(width));
      expect(actualMatrix.height, equals(height));
      expect(actualMatrix.getPixel(0, 0), isFalse); // white pixel
      expect(actualMatrix.getPixel(1, 0), isTrue); // black pixel
    });

    test('should copy matrix correctly', () {
      // Arrange
      final PixelMatrix originalMatrix = PixelMatrix.empty(3, 3);
      originalMatrix.setPixel(1, 1, true);
      originalMatrix.setPixel(2, 0, true);

      // Act
      final PixelMatrix copiedMatrix = originalMatrix.copy();

      // Assert
      expect(copiedMatrix.width, equals(originalMatrix.width));
      expect(copiedMatrix.height, equals(originalMatrix.height));
      expect(copiedMatrix.getPixel(1, 1), isTrue);
      expect(copiedMatrix.getPixel(2, 0), isTrue);
      expect(copiedMatrix.getPixel(0, 0), isFalse);

      // Modify original to ensure independence
      originalMatrix.setPixel(0, 0, true);
      expect(copiedMatrix.getPixel(0, 0), isFalse);
    });

    test('should resize matrix correctly', () {
      // Arrange
      final PixelMatrix originalMatrix = PixelMatrix.empty(2, 2);
      originalMatrix.setPixel(0, 0, true);
      originalMatrix.setPixel(1, 1, true);

      // Act
      final PixelMatrix resizedMatrix = originalMatrix.resize(4, 4);

      // Assert
      expect(resizedMatrix.width, equals(4));
      expect(resizedMatrix.height, equals(4));

      // Check scaled pixels
      expect(resizedMatrix.getPixel(0, 0), isTrue); // (0,0) -> (0,0)
      expect(resizedMatrix.getPixel(3, 3), isTrue); // (1,1) -> (3,3)
    });

    test('should generate debug string correctly', () {
      // Arrange
      final PixelMatrix matrix = PixelMatrix.empty(3, 2);
      matrix.setPixel(0, 0, true);
      matrix.setPixel(2, 1, true);

      // Act
      final String debugString = matrix.toDebugString();

      // Assert
      expect(debugString, contains('█')); // filled pixel
      expect(debugString, contains('░')); // empty pixel
      expect(debugString.split('\n').length, equals(3)); // 2 rows + empty line
    });
  });
}
