import 'package:flutter/material.dart';
import 'package:lite_chat/core/themes/cubit/theme_switch_cubit.dart';
import 'package:lite_chat/presentation/screens/near_by_friends_screen/nearByFriends.dart';
import 'package:lite_chat/presentation/screens/register_screen/signInPage.dart';
import 'package:lite_chat/presentation/screens/profile_screen/userProfilePage.dart';
import 'package:lite_chat/presentation/screens/home_screen/widgets/profileAvatar.dart';
import 'package:lite_chat/core/themes/cubit/theme_switch_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerSection extends StatelessWidget {
  const DrawerSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  Container(
                    alignment: Alignment.center,
                    height: 92,
                    width: 92,
                    padding: EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey[400]),
                    child: ProfileAvatar(
                      func: () {
                        return Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserProfilePage()));
                      },
                      height: 90,
                      width: 90,
                    ),
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
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    side:
                        BorderSide(color: Theme.of(context).primaryColorLight),
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
