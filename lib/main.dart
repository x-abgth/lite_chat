import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lite_chat/screens/allContacts.dart';
import 'package:lite_chat/screens/onlineList.dart';
import 'package:lite_chat/screens/recentChatList.dart';
import 'package:lite_chat/sections/drawerSection.dart';
import 'package:lite_chat/shared/profileAvatar.dart';
import 'utils/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lite Chat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: kAccentColor,
        accentColor: kPrimaryColor,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          child: DrawerSection(),
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, scroll) {
            return [
              SliverAppBar(
                backgroundColor: Colors.purple,
                automaticallyImplyLeading: false,
                expandedHeight: 130,
                title: Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 5),
                  child: Row(
                    children: [
                      ProfileAvatar(
                        func: () {
                          _scaffoldKey.currentState!.openDrawer();
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text('lite chat',
                            style: GoogleFonts.dancingScript(
                                fontSize: 30, fontWeight: FontWeight.bold)),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.search),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AllContacts()));
                        },
                        icon: Icon(Icons.add_outlined),
                      ),
                    ],
                  ),
                ),
                floating: true,
                snap: true,
                pinned: true,
                flexibleSpace: Container(
                  height: size.height,
                  width: size.width,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [kPrimaryColor, kSecondaryColor],
                          begin: Alignment.topLeft,
                          end: Alignment.centerRight)),
                ),
                bottom: TabBar(
                  indicatorColor: Colors.white,
                  indicatorWeight: 3,
                  tabs: [
                    Tab(text: "Recent"),
                    Tab(text: "Online"),
                  ],
                ),
              ),
            ];
          },
          body: Container(
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
            child: TabBarView(children: [
              RecentChatList(),
              OnlineList(),
            ]),
          ),
        ),
      ),
    );
  }

  Widget buildMenuBt({required BuildContext context}) {
    return GestureDetector(
      onTap: () {
        _scaffoldKey.currentState!.openDrawer();
      },
      child: Container(
        height: 40,
        width: 40,
        margin: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage("assets/default-avatar.jpg"),
            )),
      ),
    );
  }
}
