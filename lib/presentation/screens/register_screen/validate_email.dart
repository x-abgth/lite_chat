import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lite_chat/presentation/screens/home_screen/home_screen.dart';
import '../../../data/services/firebase_auth.dart';

class ValidateEmail extends StatefulWidget {
  const ValidateEmail({Key? key}) : super(key: key);

  @override
  State<ValidateEmail> createState() => _ValidateEmailState();
}

class _ValidateEmailState extends State<ValidateEmail> {
  final FirebaseAuthMethods firebaseAuthMethods = FirebaseAuthMethods();
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();
      timer = Timer.periodic(Duration(seconds: 3), (_) => checkEmailVerified());
    }

    super.initState();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      // updating the flag canResendEmail
      setState(() {
        canResendEmail = false;
      });
      await Future.delayed(Duration(seconds: 30));
      setState(() {
        canResendEmail = true;
      });
    } on Exception catch (e) {
      print("ERROR: $e");
      Fluttertoast.showToast(
        msg: e.toString(),
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  // Future verifyEmail() async {
  //   firebaseAuthMethods.sendEmailVerification();
  //   setState(() {
  //     canResendEmail = false;
  //   });
  //   await Future.delayed(Duration(minutes: 1));
  //   setState(() {
  //     canResendEmail = true;
  //   });
  // }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return isEmailVerified
        ? HomeScreen()
        : SafeArea(
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
                              onPressed:
                                  canResendEmail ? sendVerificationEmail : null,
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
