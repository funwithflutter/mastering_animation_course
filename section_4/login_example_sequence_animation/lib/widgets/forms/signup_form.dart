import 'package:flutter/material.dart';

import '../../styles/colors.dart';
import 'call_to_action_button.dart';
import 'call_to_action_text.dart';
import 'text_input_box.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm(
      {Key key,
      @required this.onLoginPressed,
      @required this.onSignUpPressed,
      @required this.safeArea})
      : super(key: key);

  final VoidCallback onLoginPressed;
  final VoidCallback onSignUpPressed;
  final double safeArea;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: safeArea),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CallToActionText('Create an account'),
              ),
              TextInputBox(
                icon: Icons.portrait,
                hintText: 'Name',
              ),
              TextInputBox(
                icon: Icons.email,
                hintText: 'Email',
              ),
              TextInputBox(
                icon: Icons.lock_outline,
                hintText: 'Password',
                obscureText: true,
              ),
              CallToActionButton(
                  onPressed: onSignUpPressed,
                  text: 'Sign Up',
                  color: headerSignUpColor),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CallToActionText('Already have an account?'),
                  CallToActionButton(
                    text: 'Sign in',
                    onPressed: onLoginPressed,
                    color: headerLoginColor,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
