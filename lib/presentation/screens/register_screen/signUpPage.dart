import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lite_chat/data/services/firebase_auth.dart';
import 'package:lite_chat/presentation/screens/register_screen/signInPage.dart';
import 'package:lite_chat/presentation/screens/register_screen/widgets/text_input_decoration.dart';

import '../../../main.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  final FirebaseAuthMethods firebaseAuthMethods = FirebaseAuthMethods();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  signMeUp() {
    dynamic user = "";
    if (formKey.currentState!.validate()) {
      user = firebaseAuthMethods.createUser(
          emailController.text, passwordController.text);
      print(user);
      if (user != "")
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
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
          backgroundColor: Colors.transparent,
          body: Container(
            width: size.width,
            height: size.height,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Sign-up Page",
                      style: GoogleFonts.dancingScript(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(height: size.height / 9),
                    buildTextFields(
                        label: "Name",
                        icon: Icons.person,
                        controller: nameController,
                        validate: (val) {
                          return val!.isEmpty || val.length < 2
                              ? "Please enter a valid name"
                              : null;
                        }),
                    buildTextFields(
                        label: "E-Mail",
                        icon: Icons.mail,
                        controller: emailController,
                        validate: (val) {
                          return RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(val ?? "")
                              ? null
                              : "Enter a valid email address";
                        }),
                    buildTextFields(
                        label: "Password",
                        icon: Icons.lock,
                        controller: passwordController,
                        isPass: true,
                        validate: (val) {
                          return val!.length < 6
                              ? "Password must be atleast 6 characters"
                              : null;
                        }),
                    SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        signMeUp();
                      },
                      child: Text("Sign Up"),
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          primary: Theme.of(context).primaryColor,
                          shape: StadiumBorder(),
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15)),
                    ),
                    SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          child: RichText(
                            text: TextSpan(
                              text: "Already have an account? ",
                              style: TextStyle(color: Colors.white),
                              children: [
                                TextSpan(
                                  text: "Login",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.white),
                                )
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => SignInPage()));
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding buildTextFields(
      {required String label,
      required IconData icon,
      required TextEditingController controller,
      required String? Function(String?) validate,
      bool isPass = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
      child: TextFormField(
        controller: controller,
        obscureText: isPass,
        cursorColor: Colors.white,
        style: AuthInputs.inputStyle(),
        decoration: AuthInputs.inputDecoration(icon: icon, label: label),
        validator: validate,
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
