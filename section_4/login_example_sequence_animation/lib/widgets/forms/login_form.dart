import 'package:flutter/material.dart';

import '../../styles/colors.dart';
import 'call_to_action_button.dart';
import 'call_to_action_text.dart';
import 'text_input_box.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
    required this.onLoginPressed,
    required this.onSignUpPressed,
    required this.safeArea,
  }) : super(key: key);

  final VoidCallback onSignUpPressed;
  final VoidCallback onLoginPressed;
  final double safeArea;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: safeArea),
          child: Column(
            children: <Widget>[
              const Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: CallToActionText('Please sign in to continue')),
              const TextInputBox(
                icon: Icons.email,
                hintText: 'Email',
              ),
              const TextInputBox(
                icon: Icons.lock_outline,
                hintText: 'Password',
                obscureText: true,
              ),
              CallToActionButton(
                onPressed: onLoginPressed,
                text: 'Login',
                color: headerLoginColor,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const CallToActionText("Don't have an account?"),
                  CallToActionButton(
                    onPressed: onSignUpPressed,
                    text: 'Sign Up',
                    color: headerSignUpColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
