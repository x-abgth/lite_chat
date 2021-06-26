import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lite_chat/screens/chatScreen.dart';
import 'package:lite_chat/shared/profileAvatar.dart';
import 'package:lite_chat/utils/dummyAccounts.dart';

class RecentChatList extends StatelessWidget {
  List<DummyAccounts> _users = [
    DummyAccounts(
        profileAvatar: ProfileAvatar(func: () {}),
        msgs: "AAahhm",
        time: "6:36 PM",
        username: "bullet_lover_"),
    DummyAccounts(
        profileAvatar: ProfileAvatar(func: () {}),
        msgs: "Eda",
        time: "5:05 PM",
        username: "aishu___",
        isSent: true),
    DummyAccounts(
        profileAvatar: ProfileAvatar(
          func: () {},
          isOnline: true,
          img: AssetImage("assets/moto_psych.jpg"),
        ),
        msgs: "Report aaya??",
        time: "4:57 PM",
        username: "moto_psych",
        seen: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        itemBuilder: (context, index) {
          return Material(
            color: Colors.transparent,
            child: ListTile(
              leading: _users[index].profileAvatar,
              title: Text(_users[index].username,
                  style: TextStyle(
                      fontWeight: _users[index].seen
                          ? FontWeight.normal
                          : FontWeight.bold)),
              subtitle: Row(
                children: [
                  _users[index].isSent
                      ? Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(FontAwesomeIcons.solidCheckCircle,
                              size: 12, color: Colors.grey[500]),
                        )
                      : SizedBox(),
                  Text(_users[index].msgs,
                      style: TextStyle(
                          fontWeight: _users[index].seen
                              ? FontWeight.normal
                              : FontWeight.bold)),
                ],
              ),
              trailing: Text(_users[index].time),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChatScreen()));
              },
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            thickness: 1,
            endIndent: 10,
            indent: 60,
          );
        },
        itemCount: _users.length,
      ),
    );
  }
}
