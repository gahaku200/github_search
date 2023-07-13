// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import '../service/dark_theme_prefs.dart';

class DarkThemeProvider extends StateNotifier<bool> {
  DarkThemeProvider() : super(false);
  DarkThemeProvider.initialTheme({required bool defaultValue})
      : super(defaultValue);
  DarkThemePrefs darkThemePrefs = DarkThemePrefs();

  // ignore: avoid_positional_boolean_parameters
  void setDarkTheme(bool value) {
    state = value;
    darkThemePrefs.setDarkTheme(value);
  }

  Future<bool> initialState() async {
    final value = await darkThemePrefs.getTheme(defaultVal: false);
    return state = value;
  }
}

final themeState = StateNotifierProvider<DarkThemeProvider, bool>(
  (ref) => DarkThemeProvider(),
);
