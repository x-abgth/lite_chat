import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lite_chat/main.dart';
import 'package:lite_chat/screens/signUpPage.dart';
import 'package:lite_chat/utils/colors.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [kPrimaryColor, kSecondaryColor],
            begin: Alignment.topLeft,
            end: Alignment.centerRight),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Sign-in Page",
              style: GoogleFonts.dancingScript(
                  fontSize: 40, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height / 9),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: TextField(
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  icon: Icon(Icons.person, color: Colors.white70),
                  labelText: "username",
                  labelStyle: TextStyle(color: Colors.white70),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.circular(30)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: TextField(
                obscureText: true,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  icon: Icon(Icons.lock, color: Colors.white70),
                  labelText: "password",
                  labelStyle: TextStyle(color: Colors.white70),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => MyHomePage()));
              },
              child: Text("Sign In"),
              style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  primary: kPrimaryColor,
                  shape: StadiumBorder(),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15)),
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  child: Text(
                    "SKIP SIGN IN",
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => MyHomePage()));
                  },
                ),
                GestureDetector(
                  child: Text(
                    "SIGN-UP",
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SignUpPage();
                    }));
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
