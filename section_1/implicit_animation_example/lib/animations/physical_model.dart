import 'package:flutter/material.dart';

import '../styles.dart';
import '../widgets/demo_button.dart';

class PhysicalModelExample extends StatefulWidget {
  PhysicalModelExample({Key key}) : super(key: key);

  @override
  _PhysicalModelExampleState createState() => _PhysicalModelExampleState();
}

class _PhysicalModelExampleState extends State<PhysicalModelExample> {
  static const _firstColor = sunset;
  static const _secondColor = teal;
  static const _firstShadowColor = Colors.grey;
  static const _secondShadowColor = sunset;
  static const _firstBorderRadius = 0.0;
  static const _secondBorderRadius = 50.0;
  static const _firstElevation = 5.0;
  static const _secondElevation = 20.0;

  Color _color = _firstColor;
  Color _shadowColor = _firstShadowColor;
  var _borderRadius = _firstBorderRadius;
  var _elevation = _firstElevation;

  var _isFirstState = true;

  void _changePhysicalModel() {
    if (_isFirstState) {
      _changeToSecondState();
    } else {
      _changeToFirstState();
    }
    _isFirstState = !_isFirstState;
  }

  void _changeToFirstState() {
    setState(() {
      _color = _firstColor;
      _shadowColor = _firstShadowColor;
      _borderRadius = _firstBorderRadius;
      _elevation = _firstElevation;
    });
  }

  void _changeToSecondState() {
    setState(() {
      _color = _secondColor;
      _shadowColor = _secondShadowColor;
      _borderRadius = _secondBorderRadius;
      _elevation = _secondElevation;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        AnimatedPhysicalModel(
          shape: BoxShape.rectangle,
          color: _color,
          borderRadius: BorderRadius.circular(_borderRadius),
          elevation: _elevation,
          shadowColor: _shadowColor,
          duration: Duration(milliseconds: 600),
          curve: Curves.ease,
          child: SizedBox(
            width: 200,
            height: 200,
            child: Center(
              child: Text(
                'Animate Me Please',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        DemoButton(
          onPressed: (_changePhysicalModel),
          lable: 'Change',
        ),
      ],
    );
  }
}
