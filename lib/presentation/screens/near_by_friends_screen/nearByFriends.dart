import 'package:flutter/material.dart';
import '../home_screen/widgets/profileAvatar.dart';
import '../../../core/constants/dummyAccounts.dart';

class NearByFirends extends StatelessWidget {
  final List<DummyAccounts> _frnds = [
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
  final List<DummyAccounts> _others = [
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
        gradient: LinearGradient(colors: [
          Theme.of(context).primaryColor,
          Theme.of(context).colorScheme.tertiary
        ], begin: Alignment.topLeft, end: Alignment.topRight),
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
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary,
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
                            side: BorderSide(
                                color: Theme.of(context).primaryColorLight),
                            backgroundColor: Colors.transparent,
                            primary: Theme.of(context).primaryColorLight,
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
                              backgroundColor:
                                  Theme.of(context).colorScheme.tertiary,
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
