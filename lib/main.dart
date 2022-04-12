import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lite_chat/core/themes/app_theme.dart';
import 'package:lite_chat/core/themes/cubit/theme_switch_cubit.dart';
import 'package:lite_chat/presentation/screens/people_you_follow_screen/allContacts.dart';
import 'package:lite_chat/presentation/screens/home_screen/onlineList.dart';
import 'package:lite_chat/presentation/screens/home_screen/recentChatList.dart';
import 'package:lite_chat/presentation/screens/home_screen/widgets/drawerSection.dart';
import 'package:lite_chat/presentation/screens/home_screen/widgets/profileAvatar.dart';

void main() {
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
      child: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lite Chat',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: context
          .select((ThemeSwitchCubit themeCubit) => themeCubit.state.themeMode),
      home: DefaultTabController(
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
            body: HomeBody(),
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

  // Button to open app drawer from the side
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

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
