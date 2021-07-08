import 'package:flutter/material.dart';

class DetermineVisibility extends StatelessWidget {
  const DetermineVisibility({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Visibility(
          visible: constraints.maxWidth > 200 && constraints.maxHeight > 50,
          child: child,
        );
      },
    );
  }
}
