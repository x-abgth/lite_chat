import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lite_chat/shared/profileAvatar.dart';
import 'package:lite_chat/utils/colors.dart';
import 'package:lite_chat/utils/dummyAccounts.dart';

class NearByFirends extends StatelessWidget {
  List<DummyAccounts> _frnds = [
    DummyAccounts(
        profileAvatar: ProfileAvatar(
          isOnline: true,
          func: () {},
        ),
        msgs: "110m away",
        time: "",
        username: "aishu__"),
    DummyAccounts(
        profileAvatar: ProfileAvatar(
          isOnline: false,
          func: () {},
        ),
        msgs: "200m away",
        time: "",
        username: "_john"),
  ];
  List<DummyAccounts> _others = [
    DummyAccounts(
        profileAvatar: ProfileAvatar(
          isOnline: true,
          func: () {},
        ),
        msgs: "50m away",
        time: "",
        username: "prince"),
    DummyAccounts(
        profileAvatar: ProfileAvatar(
          isOnline: false,
          func: () {},
        ),
        msgs: "80m away",
        time: "",
        username: "lily"),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
          title: Text("Near by friends"),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                Color(0xFF434343),
                Color(0xFF000000),
              ],
              radius: 5,
              center: Alignment.topCenter,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "People you follow",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              Container(
                height: 150,
                child: ListView.builder(
                    itemCount: _frnds.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: _frnds[index].profileAvatar,
                        title: Text(_frnds[index].username),
                        subtitle: Text(_frnds[index].msgs),
                        trailing: OutlinedButton(
                          onPressed: () {},
                          child: Text("Following"),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.white),
                            backgroundColor: Colors.transparent,
                            primary: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            shape: StadiumBorder(),
                          ),
                        ),
                      );
                    }),
              ),
              Text(
                "Others",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              Container(
                height: 150,
                child: ListView.builder(
                    itemCount: _others.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                          leading: _others[index].profileAvatar,
                          title: Text(_others[index].username),
                          subtitle: Text(_others[index].msgs),
                          trailing: TextButton(
                            onPressed: () {},
                            child: Text("Follow"),
                            style: TextButton.styleFrom(
                              backgroundColor: kSecondaryColor,
                              primary: Colors.white,
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              shape: StadiumBorder(),
                            ),
                          ));
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
