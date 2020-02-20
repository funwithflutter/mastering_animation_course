import 'package:flutter/material.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({Key key, @required this.title, @required this.child})
      : super(key: key);

  final String title;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(title, style: Theme.of(context).textTheme.headline4),
        ),
        Expanded(child: child),
      ],
    );
  }
}
