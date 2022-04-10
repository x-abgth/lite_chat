import 'package:flutter/material.dart';
import 'widgets/profileAvatar.dart';
import '../../../core/constants/dummyAccounts.dart';

class OnlineList extends StatelessWidget {
  final List<DummyAccounts> _onlineUser = [
    DummyAccounts(
        profileAvatar: ProfileAvatar(func: () {}, isOnline: true),
        msgs: "",
        time: "",
        username: "_steve"),
    DummyAccounts(
        profileAvatar: ProfileAvatar(
          func: () {},
          isOnline: true,
          img: AssetImage("assets/moto_psych.jpg"),
        ),
        msgs: "",
        time: "",
        username: "moto_psych"),
    DummyAccounts(
        profileAvatar: ProfileAvatar(func: () {}, isOnline: true),
        msgs: "",
        time: "",
        username: "_xavier"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: _onlineUser.length,
        itemBuilder: (context, index) {
          return Material(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                leading: _onlineUser[index].profileAvatar,
                title: Text(_onlineUser[index].username),
                onTap: () {},
              ),
            ),
          );
        },
      ),
    );
  }
}
