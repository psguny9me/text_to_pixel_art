import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:text_to_pixel_art/text_to_pixel_art.dart';

void main() {
  group('Text to Pixel Art Library Tests', () {
    test('should export all required classes', () {
      // Test that all main classes are accessible
      expect(PixelMatrix, isNotNull);
      expect(PixelFontConfig, isNotNull);
      expect(PixelArtStyle, isNotNull);
      expect(PixelTextWidget, isNotNull);
      expect(TextToPixelConverter, isNotNull);
      expect(PixelArtPainter, isNotNull);
    });

    test('should create PixelFontConfig with default values', () {
      // Arrange & Act
      const PixelFontConfig config = PixelFontConfig();

      // Assert
      expect(config.fontSize, equals(16.0));
      expect(config.fontFamily, equals('monospace'));
      expect(config.fontWeight, equals(FontWeight.w100));
      expect(config.threshold, equals(80));
      expect(config.useAntiAliasing, isFalse);
    });

    test('should create PixelArtStyle with default values', () {
      // Arrange & Act
      const PixelArtStyle style = PixelArtStyle();

      // Assert
      expect(style.pixelSize, equals(4.0));
      expect(style.showGrid, isFalse);
      expect(style.gridLineWidth, equals(0.5));
    });

    test('should create factory configurations correctly', () {
      // Arrange & Act

      final PixelArtStyle largeStyle = PixelArtStyle.large();
      final PixelArtStyle smallStyle = PixelArtStyle.small();

      // Assert
      expect(largeStyle.pixelSize, equals(8.0));
      expect(smallStyle.pixelSize, equals(2.0));
    });
  });
}
