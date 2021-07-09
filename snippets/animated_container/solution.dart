import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Implicit Animation Example',
      home: Scaffold(
        body: Center(
          child: Example(),
        ),
      ),
    );
  }
}

class Example extends StatefulWidget {
  const Example({Key? key}) : super(key: key);

  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  static const double _startWidth = 100.0;
  static const double _startHeight = 100.0;
  static const Color _startColor = Colors.red;

  double width = _startWidth;
  double height = _startHeight;
  Color color = _startColor;

  void _animateContainer() {
    setState(() {
      width = (width == _startWidth) ? _startWidth * 2 : _startWidth;
      height = (height == _startHeight) ? _startHeight * 2 : _startHeight;
      color = (color == _startColor) ? Colors.blue : _startColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _animateContainer,
      child: AnimatedContainer(
        duration: Duration(seconds: 1),
        width: width,
        height: height,
        color: color,
      ),
    );
  }
}
