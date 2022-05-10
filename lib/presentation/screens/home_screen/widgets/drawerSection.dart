import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lite_chat/core/themes/cubit/theme_switch_cubit.dart';
import 'package:lite_chat/data/repositories/firebase_auth_repository.dart';
import 'package:lite_chat/main.dart';
import 'package:lite_chat/presentation/screens/near_by_friends_screen/nearByFriends.dart';
import 'package:lite_chat/presentation/screens/profile_screen/userProfilePage.dart';
import 'package:lite_chat/presentation/screens/home_screen/widgets/profileAvatar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerSection extends StatelessWidget {
  DrawerSection({Key? key}) : super(key: key);
  final firebaseAuthMethods = FirebaseAuthRepository();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          gradient: RadialGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
            ],
            radius: 5,
            center: Alignment.topCenter,
          ),
        ),
        child: ListView(children: [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(vertical: 20),
            leading: ProfileAvatar(
              func: () {
                return Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UserProfilePage()));
              },
              height: 90,
              width: 90,
            ),
            title: Text("rahul", style: TextStyle(fontSize: 20)),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.solidHeart,
                    color: Colors.red,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "220K",
                    style: TextStyle(fontSize: 17),
                  )
                ],
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: OutlinedButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserProfilePage())),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      side: BorderSide(
                          color: Theme.of(context).primaryColorLight),
                    ),
                    child: Text(
                      "View profile",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Theme.of(context).primaryColorLight,
                          ),
                    ),
                  ),
                ),
              ),
              Material(
                color: Colors.transparent,
                child: BlocBuilder<ThemeSwitchCubit, ThemeSwitchState>(
                    builder: (context, state) {
                  return IconButton(
                    padding: const EdgeInsets.only(right: 15),
                    onPressed: () {
                      print("theme switched!");
                      state.themeMode == ThemeMode.dark
                          ? context
                              .read<ThemeSwitchCubit>()
                              .updateAppTheme(toDark: false)
                          : context
                              .read<ThemeSwitchCubit>()
                              .updateAppTheme(toDark: true);
                    },
                    splashColor: Colors.grey,
                    splashRadius: 20,
                    iconSize: 35,
                    icon: Icon(state.themeMode == ThemeMode.dark
                        ? Icons.light_mode
                        : Icons.dark_mode),
                  );
                }),
              )
            ],
          ),
          SizedBox(height: 10),
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
                firebaseAuthMethods.logout();
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => MainPage()));
              }),
        ]),
      ),
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
