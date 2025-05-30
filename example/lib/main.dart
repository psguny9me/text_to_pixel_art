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
  String _displayText = 'RETRO';
  double _pixelSize = 4.0;
  double _pixelSpacing = 0.0;
  double _pixelOpacity = 1.0;
  bool _showGrid = false;
  bool _enableShadow = false;
  Color _pixelColor = Colors.black;

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
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: '픽셀아트로 변환할 텍스트를 입력하세요',
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _displayText = _textController.text.isNotEmpty
                              ? _textController.text
                              : 'RETRO';
                        });
                      },
                      child: const Text('픽셀아트 생성'),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // 설정 섹션
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

                    // 픽셀 크기 설정
                    Row(
                      children: [
                        const Expanded(child: Text('픽셀 크기:')),
                        Expanded(
                          flex: 2,
                          child: Slider(
                            value: _pixelSize,
                            min: 1.0,
                            max: 10.0,
                            divisions: 9,
                            label: _pixelSize.round().toString(),
                            onChanged: (double value) {
                              setState(() {
                                _pixelSize = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    // 픽셀 간격 설정
                    Row(
                      children: [
                        const Expanded(child: Text('픽셀 간격:')),
                        Expanded(
                          flex: 2,
                          child: Slider(
                            value: _pixelSpacing,
                            min: 0.0,
                            max: 3.0,
                            divisions: 6,
                            label: _pixelSpacing.toStringAsFixed(1),
                            onChanged: (double value) {
                              setState(() {
                                _pixelSpacing = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    // 픽셀 불투명도 설정
                    Row(
                      children: [
                        const Expanded(child: Text('픽셀 불투명도:')),
                        Expanded(
                          flex: 2,
                          child: Slider(
                            value: _pixelOpacity,
                            min: 0.1,
                            max: 1.0,
                            divisions: 9,
                            label: '${(_pixelOpacity * 100).round()}%',
                            onChanged: (double value) {
                              setState(() {
                                _pixelOpacity = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    // 그리드 표시 설정
                    Row(
                      children: [
                        const Expanded(child: Text('그리드 표시:')),
                        Switch(
                          value: _showGrid,
                          onChanged: (bool value) {
                            setState(() {
                              _showGrid = value;
                            });
                          },
                        ),
                      ],
                    ),

                    // 그림자 효과 설정
                    Row(
                      children: [
                        const Expanded(child: Text('그림자 효과:')),
                        Switch(
                          value: _enableShadow,
                          onChanged: (bool value) {
                            setState(() {
                              _enableShadow = value;
                            });
                          },
                        ),
                      ],
                    ),

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

            // 커스텀 픽셀아트 결과 섹션
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '커스텀 픽셀아트',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        // 불투명도 효과를 더 잘 보이게 하기 위한 체크무늬 배경
                        color: _pixelOpacity < 1.0
                            ? Colors.grey[100]
                            : Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Stack(
                        children: [
                          // 체크무늬 패턴 (불투명도가 1.0 미만일 때만)
                          if (_pixelOpacity < 1.0)
                            Positioned.fill(
                              child: CustomPaint(
                                painter: CheckerboardPainter(),
                              ),
                            ),
                          Center(
                            child: PixelTextWidget(
                              text: _displayText,
                              fontConfig: const PixelFontConfig(fontSize: 16),
                              artStyle: PixelArtStyle(
                                pixelSize: _pixelSize,
                                pixelColor: _pixelColor,
                                showGrid: _showGrid,
                                pixelSpacing: _pixelSpacing,
                                enableShadow: _enableShadow,
                                shadowColor: _pixelColor.withValues(alpha: 0.5),
                                shadowOffset: const Offset(2.0, 2.0),
                                shadowBlur: 3.0,
                                pixelOpacity: _pixelOpacity,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // 레트로 스타일 갤러리
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '🎮 레트로 스타일 갤러리',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),

                    // 80년대 네온 스타일
                    _buildStyleDemo(
                      '80년대 네온',
                      PixelArtStyle.neon80s(),
                      RetroColors.darkPurple,
                    ),

                    const SizedBox(height: 16),

                    // 게임보이 스타일
                    _buildStyleDemo(
                      '게임보이',
                      PixelArtStyle.gameboy(),
                      RetroColors.gameboyBackground,
                    ),

                    const SizedBox(height: 16),

                    // CRT 모니터 스타일
                    _buildStyleDemo(
                      'CRT 모니터',
                      PixelArtStyle.crtMonitor(),
                      RetroColors.crtBackground,
                    ),

                    const SizedBox(height: 16),

                    // 레트로 아케이드 스타일
                    _buildStyleDemo(
                      '레트로 아케이드',
                      PixelArtStyle.retroArcade(),
                      RetroColors.darkBlue,
                    ),

                    const SizedBox(height: 16),

                    // 반투명 스타일
                    _buildStyleDemo(
                      '반투명',
                      PixelArtStyle.translucent(
                        pixelSize: 6.0,
                        pixelColor: Colors.deepPurple,
                        backgroundColor: Colors.white,
                        pixelOpacity: 0.6,
                      ),
                      Colors.white,
                      showTransparencyPattern: true,
                    ),

                    const SizedBox(height: 16),

                    // 글래스 효과 스타일
                    _buildStyleDemo(
                      '글래스 효과',
                      PixelArtStyle.glass(),
                      Colors.blueGrey,
                      showTransparencyPattern: true,
                    ),

                    const SizedBox(height: 16),

                    // 홀로그램 효과 스타일
                    _buildStyleDemo(
                      '홀로그램',
                      PixelArtStyle.hologram(),
                      Colors.black,
                      showTransparencyPattern: true,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // 불투명도 효과 갤러리
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '✨ 불투명도 효과 갤러리',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildOpacityDemo('100%', 1.0),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildOpacityDemo('75%', 0.75),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildOpacityDemo('50%', 0.5),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildOpacityDemo('25%', 0.25),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // 색상 팔레트 정보
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '🎨 레트로 색상 팔레트',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    _buildColorPalette('80년대 네온', [
                      RetroColors.neonPink,
                      RetroColors.neonBlue,
                      RetroColors.neonGreen,
                      RetroColors.neonYellow,
                      RetroColors.neonOrange,
                      RetroColors.neonPurple,
                    ]),
                    const SizedBox(height: 12),
                    _buildColorPalette('게임보이', [
                      RetroColors.gameboyGreen,
                      RetroColors.gameboyDarkGreen,
                      RetroColors.gameboyLightGreen,
                      RetroColors.gameboyBackground,
                    ]),
                    const SizedBox(height: 12),
                    _buildColorPalette('CRT 모니터', [
                      RetroColors.crtGreen,
                      RetroColors.crtAmber,
                      RetroColors.crtWhite,
                      RetroColors.crtBackground,
                    ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 스타일 데모 위젯
  Widget _buildStyleDemo(
    String title,
    PixelArtStyle style,
    Color containerColor, {
    bool showTransparencyPattern = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$title:', style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: containerColor,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Stack(
            children: [
              // 체크무늬 패턴 (반투명 효과용)
              if (showTransparencyPattern)
                Positioned.fill(
                  child: CustomPaint(
                    painter: CheckerboardPainter(),
                  ),
                ),
              Center(
                child: PixelTextWidget(
                  text: _displayText,
                  fontConfig: const PixelFontConfig(fontSize: 14),
                  artStyle: style,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// 불투명도 데모 위젯
  Widget _buildOpacityDemo(String title, double opacity) {
    return Column(
      children: [
        Text(title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        const SizedBox(height: 4),
        Container(
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Stack(
            children: [
              // 체크무늬 배경
              Positioned.fill(
                child: CustomPaint(
                  painter: CheckerboardPainter(),
                ),
              ),
              Center(
                child: PixelTextWidget(
                  text: 'A',
                  fontConfig: const PixelFontConfig(fontSize: 20),
                  artStyle: PixelArtStyle(
                    pixelSize: 3.0,
                    pixelColor: Colors.blue,
                    pixelOpacity: opacity,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// 색상 팔레트 위젯
  Widget _buildColorPalette(String title, List<Color> colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$title:', style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 4),
        Row(
          children: colors
              .map((color) => Container(
                    width: 30,
                    height: 30,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: color,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }

  /// 색상 선택 버튼
  Widget _colorButton(Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _pixelColor = color;
        });
      },
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
}
