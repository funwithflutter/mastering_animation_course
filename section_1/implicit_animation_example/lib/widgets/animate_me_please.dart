import 'package:flutter/material.dart';
import '../styles.dart';

class AnimateMePlease extends StatelessWidget {
  const AnimateMePlease({
    Key key,
    this.color = darkBlue,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        color: color,
        width: 200,
        height: 200,
        child: Center(
          child: Text(
            'This can be anything.',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
