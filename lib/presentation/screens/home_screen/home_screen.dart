import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lite_chat/presentation/screens/home_screen/onlineList.dart';
import '../people_you_follow_screen/allContacts.dart';
import 'recentChatList.dart';
import 'widgets/drawerSection.dart';
import 'widgets/profileAvatar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.transparent,
        drawer: Drawer(
          child: DrawerSection(),
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, scroll) {
            return [
              homePageAppBarMethod(context),
            ];
          },
          body: Container(
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
            child: TabBarView(children: [
              RecentChatList(),
              OnlineList(),
            ]),
          ),
        ),
      ),
    );
  }

  // HomePage AppBar functions
  SliverAppBar homePageAppBarMethod(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SliverAppBar(
      backgroundColor: Theme.of(context).primaryColor,
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AllContacts()));
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
          gradient: LinearGradient(colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).colorScheme.tertiary,
          ], begin: Alignment.topLeft, end: Alignment.centerRight),
        ),
      ),
      bottom: TabBar(
        indicatorColor: Colors.white,
        indicatorWeight: 5,
        tabs: [
          Tab(text: "Recent"),
          Tab(text: "Online"),
        ],
      ),
    );
  }
}
