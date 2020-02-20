import 'dart:ui';

import 'package:flutter/material.dart';

import '../styles/styles.dart';

class BinarayBackround extends StatelessWidget {
  const BinarayBackround({
    Key key,
    @required this.value,
  }) : super(key: key);

  final double value;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(color: greyBlueColor),
        AnimatedContainer(
          duration: Duration(milliseconds: 600),
        ),
        Positioned.fill(
          child: Image.asset(
            'assets/images/binary_background.png',
            color: antiFlashColor.withOpacity(0.2),
            alignment:
                Alignment.lerp(Alignment(-0.9, 0), Alignment(0.9, 0), value),
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
