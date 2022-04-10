import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lite_chat/main.dart';
import 'package:lite_chat/presentation/screens/register_screen/signInPage.dart';
import '../../../core/constants/colors.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Theme.of(context).primaryColor,
          Theme.of(context).colorScheme.tertiary
        ], begin: Alignment.topLeft, end: Alignment.centerRight),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Sign-up Page",
              style: GoogleFonts.dancingScript(
                  fontSize: 40, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height / 9),
            buildTextFields(label: "Name", icon: Icons.person),
            buildTextFields(label: "E-Mail", icon: Icons.mail),
            buildTextFields(label: "Password", icon: Icons.lock, isPass: true),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MyHomePage()));
              },
              child: Text("Sign Up"),
              style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  primary: Theme.of(context).primaryColor,
                  shape: StadiumBorder(),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15)),
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  child: Text(
                    "BACK TO SIGN IN",
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => SignInPage()));
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Padding buildTextFields(
      {required String label, required IconData icon, bool isPass = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
      child: TextField(
        obscureText: isPass,
        cursorColor: Colors.white,
        decoration: InputDecoration(
          icon: Icon(icon, color: Colors.white70),
          labelText: label,
          labelStyle: TextStyle(color: Colors.white70),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(30)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(30)),
        ),
      ),
    );
  }
}
