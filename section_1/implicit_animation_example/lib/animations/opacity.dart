import 'package:flutter/material.dart';

import '../styles.dart';
import '../widgets/animate_me_please.dart';

class OpacityExample extends StatefulWidget {
  const OpacityExample({Key key}) : super(key: key);

  @override
  _OpacityExampleState createState() => _OpacityExampleState();
}

class _OpacityExampleState extends State<OpacityExample> {
  var _sliderValue = 1.0;
  var _opacity = 1.0;

  void _changeSliderValue(value) {
    setState(() {
      _sliderValue = value;
    });
  }

  void _changeOpacity(value) {
    setState(() {
      _opacity = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: AnimatedOpacity(
            duration: Duration(seconds: 1),
            opacity: _opacity,
            curve: Curves.ease,
            child: AnimateMePlease(color: salmon),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Slider(
            activeColor: salmon,
            inactiveColor: mustard,
            value: _sliderValue,
            onChanged: _changeSliderValue,
            onChangeEnd: _changeOpacity,
          ),
        ),
      ],
    );
  }
}
