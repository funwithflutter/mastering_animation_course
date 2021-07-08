import 'package:flutter/material.dart';

import '../styles.dart';
import '../widgets/animate_me_please.dart';

class AlignExample extends StatefulWidget {
  const AlignExample({Key? key}) : super(key: key);

  @override
  _AlignDemoState createState() => _AlignDemoState();
}

class _AlignDemoState extends State<AlignExample> {
  Alignment _alignment = Alignment.center;

  void _changeAlignment(Alignment value) {
    setState(() {
      _alignment = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedAlign(
          alignment: _alignment,
          duration: const Duration(milliseconds: 600),
          curve: Curves.ease,
          child: const AnimateMePlease(color: salmon),
        ),
        AlignmentButton(
          alignment: Alignment.topLeft,
          onPressed: _changeAlignment,
        ),
        AlignmentButton(
          alignment: Alignment.topCenter,
          onPressed: _changeAlignment,
        ),
        AlignmentButton(
          alignment: Alignment.topRight,
          onPressed: _changeAlignment,
        ),
        AlignmentButton(
          alignment: Alignment.centerLeft,
          onPressed: _changeAlignment,
        ),
        AlignmentButton(
          alignment: Alignment.center,
          onPressed: _changeAlignment,
        ),
        AlignmentButton(
          alignment: Alignment.centerRight,
          onPressed: _changeAlignment,
        ),
        AlignmentButton(
          alignment: Alignment.bottomLeft,
          onPressed: _changeAlignment,
        ),
        AlignmentButton(
          alignment: Alignment.bottomCenter,
          onPressed: _changeAlignment,
        ),
        AlignmentButton(
          alignment: Alignment.bottomRight,
          onPressed: _changeAlignment,
        ),
      ],
    );
  }
}

typedef VoidCallbackAlignment = void Function(Alignment);

class AlignmentButton extends StatelessWidget {
  const AlignmentButton({
    Key? key,
    required this.alignment,
    required this.onPressed,
  }) : super(key: key);

  final Alignment alignment;
  final VoidCallbackAlignment onPressed;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: IconButton(
        icon: const Icon(Icons.control_point),
        onPressed: () {
          onPressed(alignment);
        },
      ),
    );
  }
}
