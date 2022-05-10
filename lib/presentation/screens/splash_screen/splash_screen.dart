import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Theme.of(context).primaryColor,
          Theme.of(context).colorScheme.tertiary
        ], begin: Alignment.topLeft, end: Alignment.centerRight),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          padding: const EdgeInsets.all(50),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'lite chat',
                      style: GoogleFonts.dancingScript(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    LinearProgressIndicator(
                      backgroundColor: Color(0xFFB8B8B8).withOpacity(0.3),
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  buildCreditText(title: "from"),
                  buildCreditText(
                      title: "ABGTH", textSize: 22, weight: FontWeight.bold),
                ],
              )
            ],
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
}
