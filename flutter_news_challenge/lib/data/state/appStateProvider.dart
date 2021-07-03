import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_news_challenge/data/state/settingsThemeState.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'favoritesState.dart';
import 'navigationState.dart';
import 'newsState.dart';

class AppStateProvider with ChangeNotifier, NavigationState, SettingsThemeState,
    NewsState, FavoritesState{
  bool _isPreferencesReady = false;

  /// Init the state machine
  AppStateProvider(BuildContext context){}

  /// Repaint the app
  void refresh() {
    notifyListeners();
  }

  void loadPreferences(BuildContext context) async {
    if(!_isPreferencesReady) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if(this.loadThemePreferences(prefs, context)){
        this.refresh();
      }

      this.loadFavorites();

      _isPreferencesReady = true;
    }
  }

}