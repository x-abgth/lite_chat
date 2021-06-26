import 'package:flutter/material.dart';
import 'package:lite_chat/screens/nearByFriends.dart';
import 'package:lite_chat/screens/signInPage.dart';
import 'package:lite_chat/screens/userProfilePage.dart';
import 'package:lite_chat/shared/profileAvatar.dart';

class DrawerSection extends StatelessWidget {
  const DrawerSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: ListView(children: [
        Container(
          height: 150,
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => UserProfilePage())),
            child: Material(
              color: Colors.transparent,
              child: Row(
                children: [
                  ProfileAvatar(
                    func: () {
                      return Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserProfilePage()));
                    },
                    height: 90,
                    width: 90,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Text("_ravuzz", style: TextStyle(fontSize: 18)),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Column(
                              children: [
                                Text("Followers"),
                                Text(
                                  "0",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(width: 30),
                            Column(
                              children: [
                                Text("Following"),
                                Text("2",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold))
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Divider(thickness: 1),
        buildDrawerList(
            iconData: Icons.chat_bubble,
            title: "Chat",
            action: () {
              print("Goto Chats");
            }),
        buildDrawerList(
            iconData: Icons.location_on,
            title: "Near By Friends",
            action: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NearByFirends()));
            }),
        buildDrawerList(
            iconData: Icons.settings, title: "Settings", action: () {}),
        buildDrawerList(iconData: Icons.info, title: "About", action: () {}),
        buildDrawerList(
            iconData: Icons.exit_to_app,
            title: "Sign Out",
            action: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => SignInPage()));
            }),
      ]),
    );
  }

  Widget buildDrawerList(
      {required IconData iconData,
      required String title,
      required void Function() action}) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: ListTile(
          leading: Icon(
            iconData,
            color: Colors.grey[600],
          ),
          title: Text(
            title,
            style: TextStyle(fontSize: 17),
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: Colors.grey[600],
          ),
          onTap: action,
        ),
      ),
    );
  }
}
