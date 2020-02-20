import 'package:flutter/material.dart';

import '../styles/backgrounds.dart';

class ExpandingPageAnimation extends StatelessWidget {
  const ExpandingPageAnimation({
    Key key,
    @required double width,
    @required double height,
    @required double borderRadius,
  })  : _width = width,
        _height = height,
        _borderRadius = borderRadius,
        super(key: key);

  final double _width;
  final double _height;
  final double _borderRadius;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
        width: _width,
        height: _height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(_borderRadius),
            gradient: linearGradientHomeDecoration()),
      ),
    );
  }
}
