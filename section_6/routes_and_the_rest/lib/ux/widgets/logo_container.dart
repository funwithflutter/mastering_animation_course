import 'package:flutter/material.dart';

import '../../models/content_model.dart';
import '../pages/info_page.dart';
import '../styles/styles.dart';

class LogoContainer extends StatelessWidget {
  const LogoContainer({
    Key key,
    @required this.content,
    @required this.scale,
  }) : super(key: key);

  final ContentModel content;
  final double scale;

  static final _scaleSequence = TweenSequence(
    <TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 1.0, end: 3.0)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 50.0,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 3.0, end: 1)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 50.0,
      ),
    ],
  );

  Route _createFadeRoute() {
    return PageRouteBuilder<dynamic>(
      transitionDuration: const Duration(milliseconds: 600),
      pageBuilder: (context, animation, secondaryAnimation) =>
          InfoPage(content: content),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var opacityTween = Tween<double>(begin: 0, end: 1).chain(
          CurveTween(curve: Curves.easeOut),
        );
        var opacityAnimation = animation.drive(opacityTween);
        return FadeTransition(
          opacity: opacityAnimation,
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var size = constraints.maxHeight * scale;
        return Align(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push<dynamic>(_createFadeRoute());

              /// EXAMPLE:
              /// The following is used as an example to use the default
              /// page transition defined for the current platfrom
              ///
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     settings: RouteSettings(),
              //     builder: (context) => InfoPage(
              //       content: content,
              //     ),
              //   ),
              // );
            },
            child: Container(
              margin: const EdgeInsets.all(8),
              height: size,
              width: size,
              child: Card(
                color: gummentalColor,
                elevation: 5 * scale,
                shape: const CircleBorder(),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _heroImage(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Hero _heroImage() {
    return Hero(
      tag: content.titleTag,
      flightShuttleBuilder:
          (flightContext, animation, flightDirection, fromContext, toContext) {
        final _scaleAnimation = _scaleSequence.animate(animation);
        return ScaleTransition(
          scale: _scaleAnimation,
          child: Image.asset(
            content.logoLocation,
            fit: BoxFit.scaleDown,
          ),
        );
      },
      child: Image.asset(
        content.logoLocation,
        fit: BoxFit.scaleDown,
      ),
    );
  }
}
