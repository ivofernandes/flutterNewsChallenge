import 'package:flutter/material.dart';
import 'package:flutter_news_challenge/screens/favoriteScreen.dart';
import 'package:flutter_news_challenge/screens/newsScreen.dart';
import 'package:flutter_news_challenge/screens/settingsScreen.dart';

class NavigationState {
  int _currentScreen = 0;
  int getCurrentScreenIndex() {
    return this._currentScreen;
  }

  Widget getCurrentScreen() {
    switch(this._currentScreen){
      case 0:
        return NewsScreen();
      case 1:
        return FavoriteScreen();
      default:
        return SettingsScreen();
    }
  }

  void updateScreen(int index) {
    this._currentScreen = index;
  }
}