import 'package:flutter/material.dart';
import 'package:transition_widgets_example/styles.dart';
import 'package:transition_widgets_example/transitions.dart/align_transition.dart';
import 'package:transition_widgets_example/transitions.dart/fade_transition.dart';
import 'package:transition_widgets_example/transitions.dart/rotate_and_scale_transition.dart';
import 'package:transition_widgets_example/transitions.dart/scale_transition.dart';
import 'package:transition_widgets_example/transitions.dart/slide_transition.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Transition Examples',
      theme: theme,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Transitions'),
        ),
        body: Center(
          child: SlideTransitionExample(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const <Widget>[
                AlignTransitionExample(),
                RotateAndScaleTransitionExample(),
                FadeTransitionExample(),
                ScaleTransitionExample(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
