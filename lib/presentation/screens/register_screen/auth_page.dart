import 'package:flutter/material.dart';
import 'package:lite_chat/presentation/screens/register_screen/signInPage.dart';
import 'package:lite_chat/presentation/screens/register_screen/signUpPage.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) => isLogin
      ? SignInPage(onClickedSignUp: toggle)
      : SignUpPage(onClickedSignUp: toggle);

  void toggle() => setState(() {
        isLogin = !isLogin;
      });
}
