import 'package:flutter/material.dart';

import '../../styles/styles.dart';
import 'wiggle_path.dart';

class WigglePainter extends CustomPainter {
  WigglePainter({
    @required this.wigglePath,
  });

  final WigglePath wigglePath;
  static final wigglePaint = Paint()..color = gummentalColor;
  static final shadowPaint = Paint()
    ..color = Colors.black38
    ..maskFilter = MaskFilter.blur(BlurStyle.normal, 5);

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    final points = wigglePath.points;
    final length = points.length;

    final midX1 = (points[length - 1].dx + points[length - 2].dx) / 2;
    final midY1 = (points[length - 1].dy + points[length - 2].dy) / 2;

    path.moveTo(midX1, midY1);

    final midX2 = (points[0].dx + points[length - 1].dx) / 2;
    final midY2 = (points[0].dy + points[length - 1].dy) / 2;

    path.quadraticBezierTo(
      points[points.length - 1].dx,
      points[points.length - 1].dy,
      midX2,
      midY2,
    );

    for (var i = 0; i < points.length - 1; i++) {
      final midX = (points[i].dx + points[i + 1].dx) / 2;
      final midY = (points[i].dy + points[i + 1].dy) / 2;
      path.quadraticBezierTo(points[i].dx, points[i].dy, midX, midY);
    }

    // canvas.drawShadow(path, Colors.black, 3, true);
    final shadowPath = path.shift(Offset(3, 3));
    canvas.drawPath(shadowPath, shadowPaint);
    canvas.drawPath(path, wigglePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
