import 'package:flutter/material.dart';

class CallToActionButton extends StatelessWidget {
  const CallToActionButton({
    Key key,
    @required this.onPressed,
    @required this.text,
    @required this.color,
  })  : assert(onPressed != null),
        super(key: key);

  final VoidCallback onPressed;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        if (onPressed != null) {
          onPressed();
        }
      },
      child: Text(text, style: TextStyle(color: color, fontSize: 16)),
    );
  }
}
