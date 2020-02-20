import 'dart:math';

import 'package:flutter/material.dart';

import '../styles/styles.dart';

class LinePainter extends CustomPainter {
  LinePainter({this.progress = 0.5});

  final double progress;

  static final linePaint = Paint()
    ..color = yellowAccentColor
    ..style = PaintingStyle.stroke
    ..strokeWidth = 6
    ..strokeCap = StrokeCap.round;

  static const _gap = 12.0;

  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height / 2;

    final widthProgress = size.width * progress;
    final point1 = max(0.0, widthProgress - _gap);
    final point2 = min(widthProgress + _gap, size.width);

    canvas.drawLine(Offset(0, height), Offset(point1, height), linePaint);
    canvas.drawLine(
        Offset(point2, height), Offset(size.width, height), linePaint);
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) {
    if (progress != oldDelegate.progress) {
      return true;
    }
    return false;
  }
}
