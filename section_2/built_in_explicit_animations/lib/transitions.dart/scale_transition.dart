import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:transition_widgets_example/styles.dart';

class ScaleTransitionExample extends HookWidget {
  const ScaleTransitionExample({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = useAnimationController(
      duration: const Duration(seconds: 1),
      lowerBound: 0,
      upperBound: 1,
    );
    final animation = Tween<double>(begin: 0.5, end: 1).animate(
      CurvedAnimation(
        curve: Curves.bounceOut,
        parent: _controller,
      ),
    );
    return ScaleTransition(
      scale: animation,
      child: GestureDetector(
        onTap: () {
          if (_controller.status == AnimationStatus.completed ||
              _controller.status == AnimationStatus.forward) {
            _controller.reverse();
          } else {
            _controller.forward();
          }
        },
        child: Container(
          color: sunset,
          width: 100,
          height: 100,
          child: const Center(
            child: Text(
              'Scale',
              style: TextStyle(fontSize: 24),
            ),
          ),
        ),
      ),
    );
  }
}
