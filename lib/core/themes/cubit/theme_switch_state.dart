part of 'theme_switch_cubit.dart';

class ThemeSwitchState extends Equatable {
  final ThemeMode themeMode;

  ThemeSwitchState({required this.themeMode});

  @override
  List<Object?> get props => [themeMode];
}
