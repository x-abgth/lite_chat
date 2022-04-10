import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'theme_switch_state.dart';

class ThemeSwitchCubit extends Cubit<ThemeSwitchState> {
  ThemeSwitchCubit() : super(ThemeSwitchState(themeMode: ThemeMode.dark)) {
    updateAppTheme();
  }

  void updateAppTheme({bool toDark = true}) {
    toDark
        ? _setAppTheme(theme: ThemeMode.dark)
        : _setAppTheme(theme: ThemeMode.light);
  }

  void _setAppTheme({required ThemeMode theme}) {
    emit(ThemeSwitchState(themeMode: theme));
  }
}
