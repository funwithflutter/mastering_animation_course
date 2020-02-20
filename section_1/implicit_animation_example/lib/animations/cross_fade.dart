import 'package:flutter/material.dart';

import '../styles.dart';
import '../widgets/animate_me_please.dart';
import '../widgets/demo_button.dart';

class CrossFadeExample extends StatefulWidget {
  CrossFadeExample({Key key}) : super(key: key);

  @override
  _CrossFadeExampleState createState() => _CrossFadeExampleState();
}

class _CrossFadeExampleState extends State<CrossFadeExample> {
  var _state = CrossFadeState.showFirst;

  void _changeState() {
    CrossFadeState newState;
    if (_state == CrossFadeState.showFirst) {
      newState = CrossFadeState.showSecond;
    } else {
      newState = CrossFadeState.showFirst;
    }
    setState(() {
      _state = newState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        AnimatedCrossFade(
          firstChild: AnimateMePlease(
            color: teal,
          ),
          secondChild: FlutterLogo(size: 200),
          duration: Duration(milliseconds: 600),
          crossFadeState: _state,
        ),
        DemoButton(
          onPressed: _changeState,
          lable: 'Change',
        ),
      ],
    );
  }
}
