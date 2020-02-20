import 'package:flutter/material.dart';

class FadeTransitionExample extends StatefulWidget {
  FadeTransitionExample({Key key}) : super(key: key);

  @override
  _FadeTransitionExampleState createState() => _FadeTransitionExampleState();
}

class _FadeTransitionExampleState extends State<FadeTransitionExample>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  String _text = 'Fade In';
  String _key = 'fadein';

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    _controller.repeat(reverse: true);
    _controller.addStatusListener(_animationStatusListener);
    super.initState();
  }

  void _animationStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.forward) {
      setState(() {
        _text = 'Fade In';
        _key = 'fadeIn';
      });
    } else if (status == AnimationStatus.reverse) {
      setState(() {
        _text = 'Fade Out';
        _key = 'fadeOut';
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return SlideTransition(
            child: child,
            position: Tween<Offset>(begin: Offset(1, 0), end: Offset(0.0, 0))
                .animate(animation),
          );
        },
        child: Text(
          _text,
          key: ValueKey<String>(_key),
          style: Theme.of(context).textTheme.headline,
        ),
      ),
    );
  }
}
