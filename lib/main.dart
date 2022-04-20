import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lite_chat/core/themes/app_theme.dart';
import 'package:lite_chat/core/themes/cubit/theme_switch_cubit.dart';
import 'package:lite_chat/data/services/firebase_auth.dart';
import 'package:lite_chat/presentation/screens/register_screen/auth_page.dart';
import 'package:lite_chat/presentation/screens/register_screen/validate_email.dart';
import 'package:lite_chat/presentation/screens/splash_screen/splash_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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
      navigatorKey: navigatorKey,
      title: 'Lite Chat',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: context
          .select((ThemeSwitchCubit themeCubit) => themeCubit.state.themeMode),
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  final FirebaseAuthMethods firebaseAuthMethods = FirebaseAuthMethods();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: firebaseAuthMethods.checkAuthentication(context),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SplashScreen();
          } else if (snapshot.hasData) {
            return ValidateEmail();
          } else {
            return AuthPage();
          }
        });
  }
}
