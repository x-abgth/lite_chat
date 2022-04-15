import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lite_chat/core/themes/app_theme.dart';
import 'package:lite_chat/core/themes/cubit/theme_switch_cubit.dart';
import 'package:lite_chat/data/services/firebase_auth.dart';
import 'package:lite_chat/presentation/screens/chat_screen/chatScreen.dart';
import 'package:lite_chat/presentation/screens/near_by_friends_screen/nearByFriends.dart';
import 'package:lite_chat/presentation/screens/people_you_follow_screen/allContacts.dart';
import 'package:lite_chat/presentation/screens/home_screen/onlineList.dart';
import 'package:lite_chat/presentation/screens/home_screen/recentChatList.dart';
import 'package:lite_chat/presentation/screens/home_screen/widgets/drawerSection.dart';
import 'package:lite_chat/presentation/screens/home_screen/widgets/profileAvatar.dart';
import 'package:lite_chat/presentation/screens/profile_screen/userProfilePage.dart';
import 'package:lite_chat/presentation/screens/register_screen/signInPage.dart';
import 'package:lite_chat/presentation/screens/splash_screen/splash_screen.dart';

import 'presentation/screens/register_screen/signUpPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeSwitchCubit>(
          create: (context) => ThemeSwitchCubit(),
        ),
      ],
      child: MyAppMaterial(),
    );
  }
}

class MyAppMaterial extends StatelessWidget {
  MyAppMaterial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lite Chat',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: context
          .select((ThemeSwitchCubit themeCubit) => themeCubit.state.themeMode),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final FirebaseAuthMethods firebaseAuthMethods = FirebaseAuthMethods();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebaseAuthMethods.checkAuthentication(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print("***********Snapshot.data = ${snapshot.data}*************");
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SplashScreen();
          } else {
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
          // else {
          //   return SignInPage();
          // }
        });
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
