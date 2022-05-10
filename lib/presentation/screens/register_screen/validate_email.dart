import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lite_chat/presentation/screens/home_screen/home_screen.dart';
import 'package:lite_chat/presentation/screens/splash_screen/splash_screen.dart';
import '../../../data/repositories/firebase_auth_repository.dart';
import '../../../logic/blocs/email_validation_bloc/email_validation_bloc.dart';

class ValidateEmail extends StatefulWidget {
  const ValidateEmail({Key? key}) : super(key: key);

  @override
  State<ValidateEmail> createState() => _ValidateEmailState();
}

class _ValidateEmailState extends State<ValidateEmail> {
  final FirebaseAuthRepository firebaseAuthMethods = FirebaseAuthRepository();
  bool canResendEmail = true;
  bool initialRequest = true;
  Timer? timer;

  @override
  void initState() {
    checkEmailVerification();
    timer =
        Timer.periodic(Duration(seconds: 3), (_) => checkEmailVerification());
    super.initState();
  }

  void checkEmailVerification() {
    BlocProvider.of<EmailValidationBloc>(context)
        .add(OnEmailValidationStatusRequested());
  }

  void sendVerification() async {
    BlocProvider.of<EmailValidationBloc>(context)
        .add(OnEmailValidationRequested());
    if (!mounted) {
      setState(() {
        canResendEmail = false;
      });
      await Future.delayed(Duration(seconds: 30));
      setState(() {
        canResendEmail = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmailValidationBloc, EmailValidationState>(
        builder: (context, state) {
      if (state is InitialEmailValidationState) {
        return SplashScreen();
      }
      if (state is EmailVerified) {
        timer?.cancel();
        return HomeScreen();
      }
      if (state is EmailNotVerified) {
        if (initialRequest) {
          sendVerification();
          initialRequest = !initialRequest;
        }
      }
      if (state is EmailVerificationError) {
        Fluttertoast.showToast(
          msg: state.error,
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG,
        );
      }
      return SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).colorScheme.tertiary
            ], begin: Alignment.topLeft, end: Alignment.centerRight),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(50),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "lite chat",
                          style: GoogleFonts.dancingScript(
                              fontSize: 50, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 15),
                        Text(
                          "A verification link has been sent your email address.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Please click on the link that has just been sent to your email account to verify your email and continue the registration process.",
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        TextButton.icon(
                          icon: Icon(Icons.email),
                          onPressed: canResendEmail ? sendVerification : null,
                          label: Text("Resend Email"),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                            primary: Theme.of(context).primaryColor,
                          ),
                        ),
                        SizedBox(height: 10),
                        TextButton(
                          onPressed: () => FirebaseAuth.instance.signOut(),
                          child: Text("Cancel"),
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      buildCreditText(title: "from"),
                      buildCreditText(
                          title: "ABGTH",
                          textSize: 22,
                          weight: FontWeight.bold),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Text buildCreditText(
      {required String title,
      double textSize = 19,
      FontWeight weight = FontWeight.normal}) {
    return Text(title,
        textAlign: TextAlign.center,
        style: GoogleFonts.robotoMono(
          color: Color(0xFFB8B8B8).withOpacity(0.6),
          fontSize: textSize,
          fontWeight: weight,
        ));
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
