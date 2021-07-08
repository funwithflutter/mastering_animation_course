import 'package:flutter/material.dart';

extension BounceExtension on Widget {
  Widget get bounceDown {
    return _BounceOutAnimation(
      child: this,
    );
  }
}

class _BounceOutAnimation extends StatefulWidget {
  const _BounceOutAnimation({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  _BounceOutAnimationState createState() => _BounceOutAnimationState();
}

class _BounceOutAnimationState extends State<_BounceOutAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  static final TweenSequence<double> _offsetTween = TweenSequence(
    <TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0, end: -25)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 50,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: -25, end: 0)
            .chain(CurveTween(curve: Curves.bounceOut)),
        weight: 50,
      ),
      TweenSequenceItem<double>(tween: ConstantTween(0), weight: 20),
    ],
  );

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animation = _offsetTween.animate(_controller);

    _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
