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

class PixelArtDemoPage extends StatefulWidget {
  const PixelArtDemoPage({super.key});

  @override
  State<PixelArtDemoPage> createState() => _PixelArtDemoPageState();
}

class _PixelArtDemoPageState extends State<PixelArtDemoPage> {
  final TextEditingController _textController = TextEditingController();
  String _displayText = 'Hello World!';
  double _pixelSize = 4.0;
  bool _showGrid = false;
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
                              : 'Hello World!';
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

            // 픽셀아트 결과 섹션
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '픽셀아트 결과',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),

                    // 기본 스타일
                    const Text('기본 스타일:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: PixelText.create(
                          text: _displayText,
                          pixelSize: _pixelSize,
                          pixelColor: _pixelColor,
                          showGrid: _showGrid,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // 작은 크기 스타일
                    const Text('작은 크기:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: PixelText.small(
                          text: _displayText,
                          pixelColor: _pixelColor,
                          showGrid: _showGrid,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // 큰 크기 스타일
                    const Text('큰 크기:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: PixelText.large(
                          text: _displayText,
                          pixelColor: _pixelColor,
                          showGrid: _showGrid,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // 여러 줄 텍스트
                    const Text('여러 줄 텍스트:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: PixelTextWidget.multiLine(
                          text: 'Line 1\nLine 2\nLine 3',
                          fontConfig: const PixelFontConfig(fontSize: 14),
                          artStyle: PixelArtStyle(
                            pixelSize: _pixelSize,
                            pixelColor: _pixelColor,
                            showGrid: _showGrid,
                          ),
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
