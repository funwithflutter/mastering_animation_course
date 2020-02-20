import 'package:flutter/material.dart';

class MenuTransitionExample extends StatusTransitionWidget {
  MenuTransitionExample({
    Key key,
    @required Animation<double> animation,
    this.child,
  }) : super(key: key, animation: animation);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final status = animation.status;
    print(status);
    if (status != AnimationStatus.dismissed) {
      return SlideTransition(
        position: animation.drive(
          Tween<Offset>(
            begin: Offset(0, 1),
            end: Offset(0, 0),
          ).chain(
            CurveTween(curve: Curves.ease),
          ),
        ),
        child: child,
      );
    } else {
      return Container();
    }
  }
}
