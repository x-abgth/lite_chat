import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lite_chat/core/themes/app_theme.dart';
import 'package:lite_chat/core/themes/cubit/theme_switch_cubit.dart';
import 'package:lite_chat/data/repositories/firebase_auth_repository.dart';
import 'package:lite_chat/logic/blocs/email_validation_bloc/email_validation_bloc.dart';
import 'package:lite_chat/presentation/screens/register_screen/auth_page.dart';
import 'package:lite_chat/presentation/screens/register_screen/validate_email.dart';
import 'package:lite_chat/presentation/screens/splash_screen/splash_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<FirebaseAuthRepository>(
            create: (context) => FirebaseAuthRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ThemeSwitchCubit>(
            create: (context) => ThemeSwitchCubit(),
          ),
          BlocProvider<EmailValidationBloc>(
              create: (context) => EmailValidationBloc(
                  firebaseAuthRepository:
                      RepositoryProvider.of<FirebaseAuthRepository>(context))),
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

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
  final FirebaseAuthRepository firebaseAuthMethods = FirebaseAuthRepository();

  @override
  Widget build(BuildContext context) {
    print(firebaseAuthMethods.checkAuthentication());
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance
            .authStateChanges(), // getting directly from backend
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
