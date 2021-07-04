import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsThemeState{

  // Theme
  static const String SETTING_THEME = 'Theme';

  static const String THEME_LIGHT = 'Light';
  static const String THEME_DARK = 'Dark';
  static const String THEME_SYSTEM = 'System';

  static const List<String> AVAILABLE_THEMES = [
    THEME_SYSTEM,
    THEME_LIGHT,
    THEME_DARK
  ];

  String _theme = THEME_SYSTEM;

  /// Load preferences from local storage
  bool loadThemePreferences(SharedPreferences prefs, BuildContext context) {
    String? preferedTheme = prefs.getString(SETTING_THEME);
    if (preferedTheme != null) {
      bool changed = _theme == preferedTheme;
      _theme = preferedTheme;
      return changed;
    }

    return false;
  }

  void updateTheme(String value) async{
    this._theme = value;

    // Don't await for the SSD persistence
    // go straight to render the update to the user
    updateThemeStore(value);
  }

  void updateThemeStore(String value) async{
    var prefs = await SharedPreferences.getInstance();

    await prefs.setString(SETTING_THEME, value);
  }

  String getLayout(){
    return this._theme;
  }


  ThemeData getTheme(BuildContext context) {
    // Get a system theme
    if(this._theme == THEME_SYSTEM) {
      String themeDescription = getSystemTheme(context);
      return getLightOrDarkTheme(themeDescription);
    }
    // Get a explicit configured light theme or dark theme
    else{
      return getLightOrDarkTheme(this._theme);
    }
  }

  ThemeData getLightOrDarkTheme(String theme){
    if(theme == THEME_DARK) {
      return ThemeData.dark();
    } else{
        return ThemeData.light();
    }
  }

  /// Go to get the theme of the DEVICE settings
  String getSystemTheme(BuildContext context) {
    var brightness = SchedulerBinding.instance!.window.platformBrightness;

    if (brightness == Brightness.dark) {
      return SettingsThemeState.THEME_DARK;
    } else{
      return SettingsThemeState.THEME_LIGHT;
    }
  }
}