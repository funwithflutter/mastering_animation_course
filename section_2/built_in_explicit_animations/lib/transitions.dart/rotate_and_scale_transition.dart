import 'package:flutter/material.dart';
import 'package:transition_widgets_example/styles.dart';

class RotateAndScaleTransitionExample extends StatefulWidget {
  const RotateAndScaleTransitionExample({Key key}) : super(key: key);

  @override
  _RotateAndScaleTransitionExampleState createState() =>
      _RotateAndScaleTransitionExampleState();
}

class _RotateAndScaleTransitionExampleState
    extends State<RotateAndScaleTransitionExample>
    with TickerProviderStateMixin {
  AnimationController _controller;
  AnimationController _controller2;
  Animation<double> _rotateAnimation;
  Animation<double> _scaleAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _controller2 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _rotateAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _controller, curve: Curves.elasticOut));
    _scaleAnimation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller2, curve: Curves.ease));
    _controller.repeat(reverse: true);
    _controller2.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: RotationTransition(
        turns: _rotateAnimation,
        child: Container(
            color: mustard,
            width: 100,
            height: 100,
            child: const Center(
              child: Text('Rotate', style: TextStyle(fontSize: 24)),
            )),
      ),
    );
  }
}
