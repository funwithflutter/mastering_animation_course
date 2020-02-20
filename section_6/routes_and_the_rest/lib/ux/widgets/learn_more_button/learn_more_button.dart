import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../styles/styles.dart';
import 'wiggle_painter.dart';
import 'wiggle_path.dart';

class LearnMoreButton extends StatefulWidget {
  const LearnMoreButton({Key key, this.onPressed}) : super(key: key);

  final VoidCallback onPressed;

  @override
  _LearnMoreButtonState createState() => _LearnMoreButtonState();
}

class _LearnMoreButtonState extends State<LearnMoreButton>
    with SingleTickerProviderStateMixin {
  WigglePath _wigglePath;
  AnimationController _controller;
  Animation<double> _animation;

  static const buttonWidth = 300.0;
  static const buttonHeight = 200.0;

  @override
  void initState() {
    _wigglePath = WigglePath(width: buttonWidth, height: buttonHeight);
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward(from: 0);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _wigglePath.randomize();
        _controller.forward(from: 0);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          _wigglePath.moveTo(_animation.value);
          return CustomPaint(
            painter: WigglePainter(wigglePath: _wigglePath),
            child: Container(
              width: buttonWidth,
              height: buttonHeight,
              child: Center(
                child: Text(
                  'Learn more',
                  style: GoogleFonts.sourceCodePro(
                      fontSize: 28, color: antiFlashColor),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
