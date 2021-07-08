import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';

import '../styles/backgrounds.dart';
import '../utils/fade_route.dart';
import '../widgets/expanding_page_animation.dart';
import '../widgets/forms/login_form.dart';
import '../widgets/forms/signup_form.dart';
import '../widgets/header.dart';
import 'home_page.dart';

enum AuthState {
  login,
  signup,
  home,
}

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage>
    with SingleTickerProviderStateMixin {
  // animation variables
  late AnimationController _controller;
  late SequenceAnimation _sequenceAnimation;

  // variables to control the transition effect to the home page
  double _expandingWidth = 0;
  double _expandingHeight = 0;
  double _expandingBorderRadius = 500;

  // constant values for the login/registration panel
  static const double _pannelWidth = 350;
  static const double _pannelHeight = 500;
  static const double _headerHeight = 60;
  static const double _borderRadius = 30;

  // variables controlling authentication state
  bool _isLogin = true;
  AuthState _authState = AuthState.login;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..addStatusListener(_animationStatusListener);

    _initSequenceAnimation();
    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _animationStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.dismissed) {
      if (_authState == AuthState.home) {
        _setHomeState();
        return;
      }

      _controller.forward(from: 0);

      if (_authState == AuthState.login) {
        _setLoginState(true);
        return;
      }
      if (_authState == AuthState.signup) {
        _setLoginState(false);
      }
    }
  }

  void _setHomeState() {
    setState(() {
      _expandingHeight = MediaQuery.of(context).size.height;
      _expandingWidth = MediaQuery.of(context).size.width;
      _expandingBorderRadius = 0;
      _routeTransition();
    });
  }

  void _setLoginState(bool isLogin) {
    setState(() {
      _isLogin = isLogin;
    });
  }

  void _initSequenceAnimation() {
    _sequenceAnimation = SequenceAnimationBuilder()
        // SCALE
        .addAnimatable(
            animatable: Tween<double>(begin: 0, end: 1),
            from: const Duration(milliseconds: 600),
            to: const Duration(milliseconds: 1200),
            curve: Curves.easeIn,
            tag: 'scale')
        // PANNEL WIDTH
        .addAnimatable(
            animatable: Tween<double>(begin: 0, end: _headerHeight),
            from: const Duration(milliseconds: 0),
            to: const Duration(milliseconds: 300),
            curve: Curves.ease,
            tag: 'width')
        .addAnimatable(
            animatable: Tween<double>(begin: _headerHeight, end: _pannelWidth),
            from: const Duration(milliseconds: 300),
            to: const Duration(milliseconds: 600),
            curve: Curves.ease,
            tag: 'width')
        // PANNEL HEIGHT
        .addAnimatable(
            animatable: Tween<double>(begin: 0, end: _headerHeight),
            from: const Duration(milliseconds: 0),
            to: const Duration(milliseconds: 300),
            curve: Curves.ease,
            tag: 'height')
        .addAnimatable(
            animatable: Tween<double>(begin: _headerHeight, end: _pannelHeight),
            from: const Duration(milliseconds: 700),
            to: const Duration(milliseconds: 1200),
            curve: Curves.linear,
            tag: 'height')
        // HEADER HEIGHT
        .addAnimatable(
            animatable: Tween<double>(begin: 0, end: _headerHeight),
            from: const Duration(milliseconds: 0),
            to: const Duration(milliseconds: 300),
            curve: Curves.ease,
            tag: 'headerHight')
        .addAnimatable(
            animatable: Tween<double>(
                begin: _headerHeight,
                end: (_pannelHeight - _headerHeight) / 2 + _headerHeight),
            from: const Duration(milliseconds: 700),
            to: const Duration(milliseconds: 950),
            curve: Curves.linear,
            tag: 'headerHight')
        .addAnimatable(
            animatable: Tween<double>(
                begin: (_pannelHeight - _headerHeight) / 2 + _headerHeight,
                end: _headerHeight),
            from: const Duration(milliseconds: 950),
            to: const Duration(milliseconds: 1200),
            curve: Curves.ease,
            tag: 'headerHight')
        // BORDER RADIUS
        .addAnimatable(
            animatable: BorderRadiusTween(
              begin: BorderRadius.circular(0),
              end: BorderRadius.circular(_borderRadius),
            ),
            from: const Duration(milliseconds: 0),
            to: const Duration(milliseconds: 600),
            curve: Curves.ease,
            tag: 'borderRadius')
        .animate(_controller);
  }

  void _onPress(AuthState state) {
    _controller.reverse();
    _authState = state;
  }

  Future<void> _routeTransition() {
    return Future.delayed(const Duration(milliseconds: 500), () {
      Navigator.pushReplacement<dynamic, dynamic>(
        context,
        FadeRoute(const HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: backgroundAuthDecoration(),
      child: Stack(
        children: <Widget>[
          ConstrainedBox(
            constraints: const BoxConstraints.expand(),
            child: const FlutterLogo(
              textColor: Colors.blueGrey,
              style: FlutterLogoStyle.markOnly,
            ),
          ),
          Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, body) {
                return ClipRRect(
                  clipBehavior: Clip.antiAlias,
                  borderRadius: BorderRadius.circular(_borderRadius),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Container(
                      height: _sequenceAnimation['height'].value as double,
                      width: _sequenceAnimation['width'].value as double,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300.withOpacity(0.1),
                        borderRadius: _sequenceAnimation['borderRadius'].value
                            as BorderRadiusGeometry?,
                      ),
                      child: Stack(
                        children: <Widget>[
                          Center(
                            child: body,
                          ),
                          Header(
                              scale:
                                  _sequenceAnimation['scale'].value as double,
                              height: _sequenceAnimation['headerHight'].value
                                  as double,
                              isLogin: _isLogin),
                        ],
                      ),
                    ),
                  ),
                );
              },
              child: _isLogin
                  ? LoginForm(
                      safeArea: _headerHeight,
                      onSignUpPressed: () {
                        _onPress(AuthState.signup);
                      },
                      onLoginPressed: () {
                        _onPress(AuthState.home);
                      },
                    )
                  : SignUpForm(
                      safeArea: _headerHeight,
                      onLoginPressed: () {
                        _onPress(AuthState.login);
                      },
                      onSignUpPressed: () {
                        _onPress(AuthState.home);
                      },
                    ),
            ),
          ),
          ExpandingPageAnimation(
            width: _expandingWidth,
            height: _expandingHeight,
            borderRadius: _expandingBorderRadius,
          ),
        ],
      ),
    );
  }
}
