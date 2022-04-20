import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lite_chat/presentation/screens/register_screen/widgets/text_input_decoration.dart';

import '../../../data/services/firebase_auth.dart';

class SignInPage extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  SignInPage({required this.onClickedSignUp});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final formKey = GlobalKey<FormState>();
  final resetFormKey = GlobalKey<FormState>();
  final scaffoldState = GlobalKey<ScaffoldState>();

  final FirebaseAuthMethods firebaseAuthMethods = FirebaseAuthMethods();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController resetEmailController = TextEditingController();

  late bool passwordObscured;

  @override
  void initState() {
    super.initState();
    passwordObscured = false;
  }

  signMeIn(BuildContext context) {
    // dynamic user = "";
    if (formKey.currentState!.validate()) {
      firebaseAuthMethods.signInWithEmailAndPassword(
          emailController.text, passwordController.text);
      passwordController.clear();

      // if (user != "") if (firebaseAuthMethods.emailVerified()) {
      //   Navigator.pushReplacement(
      //       context, MaterialPageRoute(builder: (context) => HomePage()));
      // } else {
      //   Navigator.pushReplacement(
      //       context, MaterialPageRoute(builder: (context) => ValidateEmail()));
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).colorScheme.tertiary
          ], begin: Alignment.topLeft, end: Alignment.centerRight),
        ),
        child: Scaffold(
          key: scaffoldState,
          backgroundColor: Colors.transparent,
          body: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Sign-in Page",
                  style: GoogleFonts.dancingScript(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(height: size.height / 9),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: TextFormField(
                    controller: emailController,
                    cursorColor: Colors.white,
                    textInputAction: TextInputAction.next,
                    style: AuthInputs.inputStyle(),
                    decoration: AuthInputs.inputDecoration(
                        icon: Icons.person, label: "E-Mail"),
                    validator: (val) {
                      return RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(val ?? "")
                          ? null
                          : "Enter a valid email address";
                    },
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: !passwordObscured,
                    cursorColor: Colors.white,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.emailAddress,
                    style: AuthInputs.inputStyle(),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock, color: Colors.white70),
                      suffixIcon: IconButton(
                        icon: Icon(passwordObscured
                            ? Icons.visibility
                            : Icons.visibility_off),
                        color: Colors.white60,
                        onPressed: () => setState(() {
                          passwordObscured = !passwordObscured;
                        }),
                      ),
                      labelText: "Password",
                      labelStyle: TextStyle(color: Colors.white70),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.circular(30)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.circular(30)),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 2),
                          borderRadius: BorderRadius.circular(30)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 2),
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    validator: (val) {
                      return val!.length < 6
                          ? "Password must be at least 6 characters"
                          : null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    children: [
                      Spacer(),
                      TextButton(
                        onPressed: () {
                          showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (context) =>
                                  buildBottomSheet(size, context));
                        },
                        child: Text("Forgot Password ?"),
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    signMeIn(context);
                  },
                  child: Text("Sign In"),
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      primary: Theme.of(context).primaryColor,
                      shape: StadiumBorder(),
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 15)),
                ),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(color: Colors.white),
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = widget.onClickedSignUp,
                            text: "Register",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBottomSheet(Size size, BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
          color: Colors.white,
          height: size.height / 3.5,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '''A link will be sent to the the email address provided. 
Reset the password using that link.''',
                      style: TextStyle(color: Color(0xFF434343)),
                    ),
                    SizedBox(height: 15),
                    Form(
                      key: resetFormKey,
                      child: TextFormField(
                        controller: resetEmailController,
                        cursorColor: Color(0xFF434343),
                        style: TextStyle(color: Color(0xFF434343)),
                        decoration: InputDecoration(
                          labelText: "Enter email address",
                          labelStyle: TextStyle(color: Color(0xFF434343)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF434343), width: 2),
                              borderRadius: BorderRadius.circular(30)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF434343), width: 2),
                              borderRadius: BorderRadius.circular(30)),
                          errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 2),
                              borderRadius: BorderRadius.circular(30)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 2),
                              borderRadius: BorderRadius.circular(30)),
                        ),
                        validator: (val) {
                          return RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(val ?? "")
                              ? null
                              : "Enter a valid email address";
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextButton(
                  onPressed: () {
                    if (resetFormKey.currentState!.validate()) {
                      FocusManager.instance.primaryFocus?.unfocus();
                      firebaseAuthMethods
                          .resetPassword(resetEmailController.text);
                      Navigator.pop(context);
                    }
                    resetEmailController.clear();
                  },
                  child: Text("Reset Password"),
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.tertiary,
                    primary: Colors.white,
                  ),
                ),
              )
            ],
          )),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
