import 'package:flutter/material.dart';

import '../styles/colors.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required double scale,
    required double height,
    required bool isLogin,
  })  : _scale = scale,
        _height = height,
        _isLogin = isLogin,
        super(key: key);

  final double _scale;
  final double _height;
  final bool _isLogin;

  @override
  Widget build(BuildContext context) {
    var headerText = 'Welcome';
    var color = headerLoginColor;
    if (!_isLogin) {
      headerText = "Let's get started";
      color = headerSignUpColor;
    }
    return Container(
      width: double.infinity,
      height: _height,
      color: color,
      child: Center(
        child: Transform.scale(
          scale: _scale,
          child: Text(
            headerText,
            overflow: TextOverflow.fade,
            maxLines: 1,
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  color: Colors.white,
                ),
          ),
        ),
      ),
    );
  }
}
