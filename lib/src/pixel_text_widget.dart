import 'package:flutter/material.dart';
import 'pixel_matrix.dart';
import 'pixel_font_config.dart';
import 'pixel_art_painter.dart';
import 'text_to_pixel_converter.dart';

/// 텍스트를 픽셀아트로 표시하는 위젯
class PixelTextWidget extends StatefulWidget {
  final String text;
  final PixelFontConfig fontConfig;
  final PixelArtStyle artStyle;
  final bool isMultiline;

  const PixelTextWidget({
    super.key,
    required this.text,
    this.fontConfig = const PixelFontConfig(),
    this.artStyle = const PixelArtStyle(),
    this.isMultiline = false,
  });

  /// 단일 줄 픽셀 텍스트 위젯
  factory PixelTextWidget.singleLine({
    Key? key,
    required String text,
    PixelFontConfig fontConfig = const PixelFontConfig(),
    PixelArtStyle artStyle = const PixelArtStyle(),
  }) {
    return PixelTextWidget(
      key: key,
      text: text,
      fontConfig: fontConfig,
      artStyle: artStyle,
      isMultiline: false,
    );
  }

  /// 여러 줄 픽셀 텍스트 위젯
  factory PixelTextWidget.multiLine({
    Key? key,
    required String text,
    PixelFontConfig fontConfig = const PixelFontConfig(),
    PixelArtStyle artStyle = const PixelArtStyle(),
  }) {
    return PixelTextWidget(
      key: key,
      text: text,
      fontConfig: fontConfig,
      artStyle: artStyle,
      isMultiline: true,
    );
  }

  @override
  State<PixelTextWidget> createState() => _PixelTextWidgetState();
}

class _PixelTextWidgetState extends State<PixelTextWidget> {
  PixelMatrix? _pixelMatrix;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _convertTextToPixels();
  }

  @override
  void didUpdateWidget(covariant PixelTextWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text ||
        oldWidget.fontConfig != widget.fontConfig ||
        oldWidget.isMultiline != widget.isMultiline) {
      _convertTextToPixels();
    }
  }

  /// 텍스트를 픽셀로 변환
  Future<void> _convertTextToPixels() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      PixelMatrix pixelMatrix;

      if (widget.isMultiline) {
        final List<String> lines = widget.text.split('\n');
        pixelMatrix =
            await TextToPixelConverter.convertMultilineTextToPixelMatrix(
          lines,
          widget.fontConfig,
        );
      } else {
        pixelMatrix = await TextToPixelConverter.convertTextToPixelMatrix(
          widget.text,
          widget.fontConfig,
        );
      }

      setState(() {
        _pixelMatrix = pixelMatrix;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _errorMessage = error.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return _buildLoadingWidget();
    }

    if (_errorMessage != null) {
      return _buildErrorWidget();
    }

    if (_pixelMatrix == null) {
      return _buildEmptyWidget();
    }

    return _buildPixelArt();
  }

  /// 로딩 위젯
  Widget _buildLoadingWidget() {
    return const SizedBox(
      width: 50,
      height: 20,
      child: Center(
        child: SizedBox(
          width: 16,
          height: 16,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
  }

  /// 에러 위젯
  Widget _buildErrorWidget() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.red.withValues(alpha: 0.1),
        border: Border.all(color: Colors.red),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        'Error: $_errorMessage',
        style: const TextStyle(color: Colors.red, fontSize: 12),
      ),
    );
  }

  /// 빈 위젯
  Widget _buildEmptyWidget() {
    return const SizedBox(
      width: 50,
      height: 20,
      child: Center(
        child: Text(
          'No data',
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ),
    );
  }

  /// 픽셀아트 위젯
  Widget _buildPixelArt() {
    return CustomPaint(
      size: Size(
        _pixelMatrix!.width * widget.artStyle.pixelSize,
        _pixelMatrix!.height * widget.artStyle.pixelSize,
      ),
      painter: PixelArtPainter(
        pixelMatrix: _pixelMatrix!,
        pixelSize: widget.artStyle.pixelSize,
        pixelColor: widget.artStyle.pixelColor,
        backgroundColor: widget.artStyle.backgroundColor,
        showGrid: widget.artStyle.showGrid,
        gridColor: widget.artStyle.gridColor,
        gridLineWidth: widget.artStyle.gridLineWidth,
      ),
    );
  }
}

/// 간단한 픽셀 텍스트 표시 함수
class PixelText {
  /// 기본 픽셀 텍스트 위젯 생성
  static Widget create({
    required String text,
    double pixelSize = 4.0,
    Color pixelColor = Colors.black,
    Color backgroundColor = Colors.transparent,
    double fontSize = 16.0,
    bool showGrid = false,
  }) {
    return PixelTextWidget(
      text: text,
      fontConfig: PixelFontConfig(
        fontSize: fontSize,
        textColor: pixelColor,
        backgroundColor: backgroundColor,
      ),
      artStyle: PixelArtStyle(
        pixelSize: pixelSize,
        pixelColor: pixelColor,
        backgroundColor: backgroundColor,
        showGrid: showGrid,
      ),
    );
  }

  /// 큰 크기 픽셀 텍스트 위젯 생성
  static Widget large({
    required String text,
    Color pixelColor = Colors.black,
    Color backgroundColor = Colors.transparent,
    bool showGrid = false,
  }) {
    return PixelTextWidget(
      text: text,
      fontConfig: PixelFontConfig.large(
        textColor: pixelColor,
        backgroundColor: backgroundColor,
      ),
      artStyle: PixelArtStyle.large(
        pixelColor: pixelColor,
        backgroundColor: backgroundColor,
      ).copyWith(showGrid: showGrid),
    );
  }

  /// 작은 크기 픽셀 텍스트 위젯 생성
  static Widget small({
    required String text,
    Color pixelColor = Colors.black,
    Color backgroundColor = Colors.transparent,
    bool showGrid = false,
  }) {
    return PixelTextWidget(
      text: text,
      fontConfig: PixelFontConfig.small(
        textColor: pixelColor,
        backgroundColor: backgroundColor,
      ),
      artStyle: PixelArtStyle.small(
        pixelColor: pixelColor,
        backgroundColor: backgroundColor,
      ).copyWith(showGrid: showGrid),
    );
  }
}
