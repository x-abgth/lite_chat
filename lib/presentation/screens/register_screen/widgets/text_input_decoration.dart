import 'package:flutter/material.dart';

class AuthInputs {
  static TextStyle inputStyle() {
    return TextStyle(color: Colors.white);
  }

  static InputDecoration inputDecoration(
      {required IconData icon, String label = ""}) {
    return InputDecoration(
      icon: Icon(icon, color: Colors.white70),
      labelText: label,
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
    );
  }
}
