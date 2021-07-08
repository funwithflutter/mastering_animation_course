import 'package:flutter/material.dart';

class DemoButton extends StatelessWidget {
  const DemoButton({
    Key? key,
    required this.onPressed,
    required this.lable,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String lable;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: OutlinedButton(
        style: ButtonStyle(
          side: MaterialStateProperty.all(
            const BorderSide(width: 0.5),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          lable,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
