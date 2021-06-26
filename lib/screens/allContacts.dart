import 'package:flutter/material.dart';
import '../utils/colors.dart';

class AllContacts extends StatelessWidget {
  const AllContacts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [kPrimaryColor, kSecondaryColor],
            begin: Alignment.topLeft,
            end: Alignment.topRight),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text("People you follow"),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search),
            )
          ],
        ),
        body: Container(
          color: Colors.white,
          child: Center(
              child: Text(
            "Hi",
            style: TextStyle(color: Colors.black),
          )),
        ),
      ),
    );
  }
}
