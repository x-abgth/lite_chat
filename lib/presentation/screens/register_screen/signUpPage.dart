import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lite_chat/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lite_chat/data/repositories/firebase_auth_repository.dart';
import 'package:lite_chat/presentation/screens/register_screen/widgets/text_input_decoration.dart';

class SignUpPage extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  SignUpPage({required this.onClickedSignUp});
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuthRepository firebaseAuthMethods = FirebaseAuthRepository();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController1 = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();

  late bool passwordObscured1;
  late bool passwordObscured2;

  @override
  void initState() {
    super.initState();
    passwordObscured1 = false;
    passwordObscured2 = false;
  }

  signMeUp() {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));
    firebaseAuthMethods.createUser(
        nameController.text, emailController.text, passwordController2.text);

    navigatorKey.currentState!.pop();
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
          key: scaffoldKey,
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
                        textInputType: TextInputType.emailAddress,
                        validate: (val) {
                          return RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(val ?? "")
                              ? null
                              : "Enter a valid email address";
                        }),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10),
                      child: TextFormField(
                        controller: passwordController1,
                        obscureText: !passwordObscured1,
                        cursorColor: Colors.white,
                        textInputAction: TextInputAction.next,
                        style: AuthInputs.inputStyle(),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock, color: Colors.white70),
                          suffixIcon: IconButton(
                            icon: Icon(passwordObscured1
                                ? Icons.visibility
                                : Icons.visibility_off),
                            color: Colors.white60,
                            onPressed: () => setState(() {
                              passwordObscured1 = !passwordObscured1;
                            }),
                          ),
                          labelText: "Password",
                          labelStyle: TextStyle(color: Colors.white70),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 2),
                              borderRadius: BorderRadius.circular(30)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 2),
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
                          return val!.length < 6
                              ? "Password must be at least 6 characters"
                              : null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10),
                      child: TextFormField(
                          controller: passwordController2,
                          obscureText: !passwordObscured2,
                          cursorColor: Colors.white,
                          textInputAction: TextInputAction.done,
                          style: AuthInputs.inputStyle(),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock, color: Colors.white70),
                            suffixIcon: IconButton(
                              icon: Icon(passwordObscured2
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              color: Colors.white60,
                              onPressed: () => setState(() {
                                passwordObscured2 = !passwordObscured2;
                              }),
                            ),
                            labelText: "Confirm Password",
                            labelStyle: TextStyle(color: Colors.white70),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2),
                                borderRadius: BorderRadius.circular(30)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2),
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
                            if (val != passwordController1.text) {
                              return "Passwords do not match";
                            } else if (val!.length < 6) {
                              return "Password must be at least 6 characters";
                            } else {
                              return null;
                            }
                          }),
                    ),
                    SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
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
                        RichText(
                          text: TextSpan(
                            text: "Already have an account? ",
                            style: TextStyle(color: Colors.white),
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = widget.onClickedSignUp,
                                text: "Login",
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
        ),
      ),
    );
  }

  Padding buildTextFields({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    required String? Function(String?) validate,
    TextInputType textInputType = TextInputType.text,
    TextInputAction textInputAction = TextInputAction.next,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
      child: TextFormField(
        controller: controller,
        cursorColor: Colors.white,
        keyboardType: textInputType,
        textInputAction: textInputAction,
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
    passwordController1.dispose();
    passwordController2.dispose();
    super.dispose();
  }
}
