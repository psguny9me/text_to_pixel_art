import 'package:flutter/material.dart';
import 'package:text_to_pixel_art/text_to_pixel_art.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Text to Pixel Art Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PixelArtDemoPage(),
    );
  }
}

/// 체크무늬 패턴을 그리는 커스텀 페인터
class CheckerboardPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const double squareSize = 8.0;
    final Paint lightPaint = Paint()..color = Colors.white;
    final Paint darkPaint = Paint()..color = Colors.grey[200]!;

    for (double x = 0; x < size.width; x += squareSize) {
      for (double y = 0; y < size.height; y += squareSize) {
        final bool isEven =
            ((x / squareSize).floor() + (y / squareSize).floor()) % 2 == 0;
        final Paint paint = isEven ? lightPaint : darkPaint;
        canvas.drawRect(
          Rect.fromLTWH(x, y, squareSize, squareSize),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class PixelArtDemoPage extends StatefulWidget {
  const PixelArtDemoPage({super.key});

  @override
  State<PixelArtDemoPage> createState() => _PixelArtDemoPageState();
}

class _PixelArtDemoPageState extends State<PixelArtDemoPage> {
  final TextEditingController _textController = TextEditingController();
  String _displayText = 'HELLO';

  // PixelArtStyle 설정
  double _pixelSize = 4.0;
  double _pixelSpacing = 0.0;
  double _pixelOpacity = 1.0;
  bool _showGrid = false;
  bool _enableShadow = false;
  Color _pixelColor = Colors.black;

  // PixelFontConfig 설정
  double _fontSize = 16.0;
  FontWeight _fontWeight = FontWeight.w100;
  int _threshold = 80;
  bool _useAntiAliasing = false;
  bool _useFixedSize = false;
  int _letterPixelWidth = 8;
  int _letterPixelHeight = 16;

  // 기타 설정
  bool _isMultiline = false;

  @override
  void initState() {
    super.initState();
    _textController.text = _displayText;
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Text to Pixel Art Demo'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 텍스트 입력 섹션
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '텍스트 입력',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _textController,
                      maxLines: _isMultiline ? null : 1,
                      minLines: _isMultiline ? 3 : 1,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: '픽셀아트로 변환할 텍스트를 입력하세요',
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _displayText = _textController.text.isNotEmpty
                                  ? _textController.text
                                  : 'HELLO';
                            });
                          },
                          child: const Text('픽셀아트 생성'),
                        ),
                        const SizedBox(width: 8),
                        Switch(
                          value: _isMultiline,
                          onChanged: (bool value) {
                            setState(() {
                              _isMultiline = value;
                            });
                          },
                        ),
                        const Text('멀티라인'),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // 픽셀아트 설정 섹션
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '픽셀아트 설정',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),

                    // 픽셀 크기
                    _buildSlider('픽셀 크기', _pixelSize, 1.0, 10.0, 9,
                        (value) => setState(() => _pixelSize = value)),

                    // 픽셀 간격
                    _buildSlider('픽셀 간격', _pixelSpacing, 0.0, 3.0, 6,
                        (value) => setState(() => _pixelSpacing = value)),

                    // 픽셀 불투명도
                    _buildSlider('픽셀 불투명도', _pixelOpacity, 0.1, 1.0, 9,
                        (value) => setState(() => _pixelOpacity = value)),

                    // 스위치들
                    _buildSwitch('그리드 표시', _showGrid,
                        (value) => setState(() => _showGrid = value)),
                    _buildSwitch('그림자 효과', _enableShadow,
                        (value) => setState(() => _enableShadow = value)),

                    // 색상 선택
                    Row(
                      children: [
                        const Expanded(child: Text('픽셀 색상:')),
                        Row(
                          children: [
                            _colorButton(Colors.black),
                            _colorButton(Colors.blue),
                            _colorButton(Colors.red),
                            _colorButton(Colors.green),
                            _colorButton(Colors.purple),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // 폰트 설정 섹션
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '폰트 설정',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),

                    // 스위치들
                    _buildSwitch('안티앨리어싱', _useAntiAliasing,
                        (value) => setState(() => _useAntiAliasing = value)),
                    _buildSwitch('고정 크기 모드', _useFixedSize,
                        (value) => setState(() => _useFixedSize = value)),

                    // 폰트 크기
                    _buildSlider('폰트 크기', _fontSize, 8.0, 32.0, 24,
                        (value) => setState(() => _fontSize = value)),

                    // Threshold
                    _buildSlider(
                        '픽셀 변환 임계값',
                        _threshold.toDouble(),
                        10.0,
                        200.0,
                        19,
                        (value) => setState(() => _threshold = value.round())),

                    // 고정 크기 설정
                    if (_useFixedSize) ...[
                      _buildSlider(
                          '글자 픽셀 너비',
                          _letterPixelWidth.toDouble(),
                          4.0,
                          24.0,
                          20,
                          (value) => setState(
                              () => _letterPixelWidth = value.round())),
                      _buildSlider(
                          '글자 픽셀 높이',
                          _letterPixelHeight.toDouble(),
                          4.0,
                          32.0,
                          28,
                          (value) => setState(
                              () => _letterPixelHeight = value.round())),
                    ],

                    // 폰트 굵기
                    Row(
                      children: [
                        const Expanded(child: Text('폰트 굵기:')),
                        DropdownButton<FontWeight>(
                          value: _fontWeight,
                          onChanged: (FontWeight? newValue) {
                            setState(() {
                              _fontWeight = newValue!;
                            });
                          },
                          items: const [
                            DropdownMenuItem(
                                value: FontWeight.w100, child: Text('얇음')),
                            DropdownMenuItem(
                                value: FontWeight.w300, child: Text('밝음')),
                            DropdownMenuItem(
                                value: FontWeight.normal, child: Text('보통')),
                            DropdownMenuItem(
                                value: FontWeight.w500, child: Text('중간')),
                            DropdownMenuItem(
                                value: FontWeight.bold, child: Text('굵음')),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // 결과 섹션
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '픽셀아트 결과 ${_useFixedSize ? "(${_letterPixelWidth}x${_letterPixelHeight})" : ""}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: _isMultiline
                            ? PixelTextWidget.multiLine(
                                text: _displayText,
                                fontConfig: _getSelectedFontConfig(),
                                artStyle: _getPixelArtStyle(),
                              )
                            : PixelTextWidget.singleLine(
                                text: _displayText,
                                fontConfig: _getSelectedFontConfig(),
                                artStyle: _getPixelArtStyle(),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlider(String label, double value, double min, double max,
      int divisions, Function(double) onChanged) {
    return Row(
      children: [
        Expanded(child: Text('$label:')),
        Expanded(
          flex: 2,
          child: Slider(
            value: value,
            min: min,
            max: max,
            divisions: divisions,
            label: value.toStringAsFixed(1),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildSwitch(String label, bool value, Function(bool) onChanged) {
    return Row(
      children: [
        Expanded(child: Text('$label:')),
        Switch(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _colorButton(Color color) {
    return GestureDetector(
      onTap: () => setState(() => _pixelColor = color),
      child: Container(
        width: 30,
        height: 30,
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: color,
          border: Border.all(
            color: _pixelColor == color ? Colors.black : Colors.grey,
            width: _pixelColor == color ? 3 : 1,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  PixelFontConfig _getSelectedFontConfig() {
    return PixelFontConfig(
      fontSize: _fontSize,
      fontWeight: _fontWeight,
      threshold: _threshold,
      useAntiAliasing: _useAntiAliasing,
      letterPixelWidth: _useFixedSize ? _letterPixelWidth : null,
      letterPixelHeight: _useFixedSize ? _letterPixelHeight : null,
    );
  }

  PixelArtStyle _getPixelArtStyle() {
    return PixelArtStyle(
      pixelSize: _pixelSize,
      pixelColor: _pixelColor,
      showGrid: _showGrid,
      pixelSpacing: _pixelSpacing,
      enableShadow: _enableShadow,
      shadowColor: _pixelColor.withValues(alpha: 0.5),
      shadowOffset: const Offset(2.0, 2.0),
      shadowBlur: 3.0,
      pixelOpacity: _pixelOpacity,
    );
  }
}
