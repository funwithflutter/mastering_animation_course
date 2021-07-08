import 'package:flutter/material.dart';

import 'animations/align.dart';
import 'animations/container.dart';
import 'animations/cross_fade.dart';
import 'animations/default_text_style.dart';
import 'animations/opacity.dart';
import 'animations/padding.dart';
import 'animations/physical_model.dart';
import 'animations/positioned.dart';
import 'styles.dart';
import 'widgets/demo_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Implicit Animations',
      theme: theme,
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Implicit Animations'),
          ),
          body: const ImplicitAnimations()),
    );
  }
}

class ImplicitAnimations extends StatelessWidget {
  const ImplicitAnimations({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: const <Widget>[
        DemoPage(title: 'Container', child: ContainerExample()),
        DemoPage(title: 'Cross Fade', child: CrossFadeExample()),
        DemoPage(title: 'Physical Model', child: PhysicalModelExample()),
        DemoPage(title: 'Opacity', child: OpacityExample()),
        DemoPage(title: 'Default Text Style', child: DefaultTextStyleExample()),
        DemoPage(title: 'Align', child: AlignExample()),
        DemoPage(title: 'Padding', child: PaddingExample()),
        DemoPage(title: 'Positioned', child: PositionedExample()),
      ],
    );
  }
}
