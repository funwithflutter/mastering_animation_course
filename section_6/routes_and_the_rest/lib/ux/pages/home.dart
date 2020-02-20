import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

import '../../main.dart' show routeObserver;
import '../transitions/flip_transition.dart';
import '../widgets/binary_background.dart';
import '../widgets/learn_more_button/learn_more_button.dart';
import '../widgets/zoom_page_view.dart';
import 'learn_more_page.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>
    with SingleTickerProviderStateMixin, RouteAware {
  static const double _viewPortFraction = 0.5;
  static const int _initialPage = 2;
  static const _transitionDuration = Duration(milliseconds: 850);

  final ValueNotifier<double> _valueNotifier = ValueNotifier(0.5);

  PageController _pageController;
  AnimationController _controller;

  @override
  void initState() {
    _pageController = PageController(
        initialPage: _initialPage, viewportFraction: _viewPortFraction);
    _controller = AnimationController(
      vsync: this,
      duration: _transitionDuration,
    );

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _pageController.dispose();
    routeObserver.unsubscribe(this);

    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void didPush() {
    print('push');
    super.didPush();
  }

  @override
  void didPushNext() {
    print('push next');
    super.didPushNext();
  }

  @override
  void didPopNext() {
    print('pop next');
    if (!(_controller.value > 0)) {
      return;
    }
    Timer(_transitionDuration, () {
      _controller.reverse(from: 1);
    });
    super.didPopNext();
  }

  @override
  void didPop() {
    print('pop');
    super.didPop();
  }

  void _onTransitionPressed() {
    _controller.forward(from: 0).whenComplete(_transitionRoute);
  }

  void _transitionRoute() {
    Navigator.of(context).push(_createRoute());
  }

  Route _createRoute() {
    return PageRouteBuilder(
      transitionDuration: _transitionDuration,
      pageBuilder: (context, animation, secondaryAnimation) =>
          const LearnMorePage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FlipTransition(
          isEntry: true,
          animation: ReverseAnimation(animation),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 1;
    return FlipTransition(
      isEntry: false,
      animation: _controller,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            ValueListenableBuilder(
              valueListenable: _valueNotifier,
              builder: (context, value, child) {
                return BinarayBackround(value: _valueNotifier.value);
              },
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                // Padding(
                //   padding: const EdgeInsets.all(16.0),
                //   child: Text(
                //     'Front-end Frameworks',
                //     style: Theme.of(context).textTheme.display1,
                //   ),
                // ),
                ZoomPageScroll(
                  pageController: _pageController,
                  value: _valueNotifier,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: LearnMoreButton(
                    onPressed: _onTransitionPressed,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
