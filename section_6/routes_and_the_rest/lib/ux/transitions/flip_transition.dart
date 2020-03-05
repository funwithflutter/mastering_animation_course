import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class FlipTransition extends AnimatedWidget {
  static const double beginScale = 1;
  static const double endScale = 1.8;
  static const double beginRotation = 0;
  static const double midRotation = pi / 2;
  static const double endRotation = pi;

  FlipTransition({
    Key key,
    Animation<double> animation,
    this.child,
    bool isEntry = true,
  })  : offsetXTween = Tween<double>(begin: isEntry ? -15 : 15, end: 2),
        scaleSequence = TweenSequence(
          <TweenSequenceItem<double>>[
            TweenSequenceItem<double>(
              tween: Tween<double>(begin: beginScale, end: endScale)
                  .chain(CurveTween(curve: Curves.easeIn)),
              weight: 40.0,
            ),
            TweenSequenceItem<double>(
              tween: ConstantTween<double>(endScale),
              weight: 60.0,
            ),
          ],
        ),
        rotateSequence = TweenSequence(
          <TweenSequenceItem<double>>[
            TweenSequenceItem<double>(
              tween:
                  ConstantTween<double>(isEntry ? endRotation : beginRotation)
                      .chain(CurveTween(curve: Curves.ease)),
              weight: 60.0,
            ),
            TweenSequenceItem<double>(
              tween: Tween<double>(
                      begin: isEntry ? endRotation : beginRotation,
                      end: midRotation)
                  .chain(
                CurveTween(curve: isEntry ? Curves.easeIn : Curves.easeOut),
              ),
              weight: 40.0,
            ),
          ],
        ),
        super(
          key: key,
          listenable: animation,
        );

  final Widget child;

  final TweenSequence<double> scaleSequence;
  final TweenSequence<double> rotateSequence;

  final Tween<double> spreadTween = Tween<double>(begin: 5, end: 0);
  final Tween<double> blurTween = Tween<double>(begin: 10, end: 0);
  final Tween<double> offsetXTween;
  final Tween<double> offsetYTween = Tween<double>(begin: 10, end: 0);

  Animation<double> get scale => scaleSequence.animate(listenable);
  Animation<double> get rotation => rotateSequence.animate(listenable);
  Animation<double> get shadowSpread => spreadTween.animate(
        CurvedAnimation(
          parent: listenable,
          curve: Curves.easeIn,
        ),
      );
  Animation<double> get blur => blurTween.animate(
        CurvedAnimation(
          parent: listenable,
          curve: Curves.easeIn,
        ),
      );
  Animation<double> get offsetX => offsetXTween.animate(
        CurvedAnimation(
          parent: listenable,
          curve: Curves.easeInOut,
        ),
      );
  Animation<double> get offsetY => offsetYTween.animate(
        CurvedAnimation(
          parent: listenable,
          curve: Curves.easeInOut,
        ),
      );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Container(color: Colors.grey[200]),
        Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 3, scale.value)
            ..setEntry(3, 2, -0.001)
            ..rotateY(rotation.value),
          origin: Offset(size.width / 2, size.height / 2),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius:
                      blur.value, // has the effect of softening the shadow
                  spreadRadius:
                      shadowSpread.value, // has the effect of extending the shadow
                  offset: Offset(
                    offsetX.value,
                    offsetY.value,
                  ),
                ),
              ],
            ),
            child: RotationY(
              child: FadeTransition(
                opacity: ReverseAnimation(listenable),
                child: child,
              ),
              rotationY: rotation.value >= pi / 2 ? 180 : 0,
            ),
          ),
        ),
      ],
    );
  }
}

class RotationY extends StatelessWidget {
  //Degrees to rads constant
  static const double degrees2Radians = pi / 180;

  final Widget child;
  final double rotationY;

  const RotationY({Key key, @required this.child, this.rotationY = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform(
        alignment: FractionalOffset.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, -0.001) // These are magic numbers, just use them :)
          ..rotateY(rotationY * degrees2Radians),
        child: child);
  }
}
