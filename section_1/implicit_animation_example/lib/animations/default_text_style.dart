import 'package:flutter/material.dart';

import '../styles.dart';
import '../widgets/demo_button.dart';

class DefaultTextStyleExample extends StatefulWidget {
  DefaultTextStyleExample({Key key}) : super(key: key);

  @override
  _DefaultTextStyleExampleState createState() =>
      _DefaultTextStyleExampleState();
}

class _DefaultTextStyleExampleState extends State<DefaultTextStyleExample> {
  static const _firstFontSize = 28.0;
  static const _secondFontSize = 64.0;

  static const _firstColor = sunset;
  static const _secondColor = darkBlue;

  static const _firstFont = 'OpenSans';
  static const _secondFont = 'LiuJianMaoCao';

  static const _firstSpacing = 1.0;
  static const _secondSpacing = 10.0;

  static const _firstBackgroundColor = Colors.transparent;
  static const _secondBackgroundColor = Colors.grey;

  static const _firstWeight = FontWeight.w200;
  static const _secondWeight = FontWeight.bold;

  var _fontSize = _firstFontSize;
  var _color = _firstColor;
  var _font = _firstFont;
  var _letterSpacing = _firstSpacing;
  var _backgroundColor = _firstBackgroundColor;
  var _weight = _firstWeight;

  void _animateSize() {
    setState(() {
      _fontSize =
          _fontSize == _firstFontSize ? _secondFontSize : _firstFontSize;
    });
  }

  void _animateColor() {
    setState(() {
      _color = _color == _firstColor ? _secondColor : _firstColor;
    });
  }

  void _animateFont() {
    setState(() {
      _font = _font == _firstFont ? _secondFont : _firstFont;
    });
  }

  void _animateSpacing() {
    setState(() {
      _letterSpacing =
          _letterSpacing == _firstSpacing ? _secondSpacing : _firstSpacing;
    });
  }

  void _animateBackground() {
    setState(() {
      _backgroundColor = _backgroundColor == _firstBackgroundColor
          ? _secondBackgroundColor
          : _firstBackgroundColor;
    });
  }

  void _animateWeight() {
    setState(() {
      _weight = _weight == _firstWeight ? _secondWeight : _firstWeight;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Center(
            child: AnimatedDefaultTextStyle(
              duration: Duration(milliseconds: 600),
              style: TextStyle(
                fontSize: _fontSize,
                color: _color,
                backgroundColor: _backgroundColor,
                fontFamily: _font,
                fontWeight: _weight,
                letterSpacing: _letterSpacing,
              ),
              curve: Curves.ease,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Animate'),
              ),
            ),
          ),
        ),
        Expanded(
          child: GridView.count(
            crossAxisCount: 3,
            children: <Widget>[
              DemoButton(
                onPressed: _animateSize,
                lable: 'Size',
              ),
              DemoButton(
                onPressed: _animateColor,
                lable: 'Color',
              ),
              DemoButton(
                onPressed: _animateFont,
                lable: 'Font',
              ),
              DemoButton(
                onPressed: _animateSpacing,
                lable: 'Spacing',
              ),
              DemoButton(
                onPressed: _animateBackground,
                lable: 'Background Color',
              ),
              DemoButton(
                onPressed: _animateWeight,
                lable: 'Weight',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
