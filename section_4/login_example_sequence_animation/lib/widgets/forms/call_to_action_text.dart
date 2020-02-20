import 'package:flutter/material.dart';

class CallToActionText extends StatelessWidget {
  const CallToActionText(this.text, {Key key}) : super(key: key);

  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
          Theme.of(context).textTheme.subtitle1.copyWith(color: Colors.white70),
    );
  }
}
