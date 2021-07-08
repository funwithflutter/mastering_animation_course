import 'package:flutter/material.dart';

class RotateScaleTransition extends AnimatedWidget {
  const RotateScaleTransition(
      {Key key, @required Animation<double> animation, this.child})
      : assert(animation != null),
        super(key: key, listenable: animation);

  final Widget child;

  Animation<double> get animation => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: animation,
      child: ScaleTransition(
        scale: ReverseAnimation(animation),
        child: child,
      ),
    );
  }
}
