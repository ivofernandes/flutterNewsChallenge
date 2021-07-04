import 'package:flutter/material.dart';
import 'package:flutter_news_challenge/data/state/connectivityState.dart';
import 'package:flutter_news_challenge/data/state/settings/settingsThemeState.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'article/favoritesState.dart';
import 'navigationState.dart';
import 'article/newsState.dart';

class AppStateProvider with ChangeNotifier, NavigationState, SettingsThemeState,
    NewsState, FavoritesState , ConnectivityState{
  bool _isPreferencesReady = false;

  /// Init the state machine
  AppStateProvider(BuildContext context){
    initConnectivity().then((value) {
      this.refresh();
    });
  }

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