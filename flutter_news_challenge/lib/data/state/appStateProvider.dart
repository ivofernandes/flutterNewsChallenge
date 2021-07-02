import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_news_challenge/data/model/article.dart';
import 'package:flutter_news_challenge/data/services/newsService.dart';
import 'package:flutter_news_challenge/data/state/settingsThemeState.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'navigationState.dart';

class AppStateProvider with ChangeNotifier, NavigationState, SettingsThemeState{
  bool _isPreferencesReady = false;

  String _deviceLanguage = '';

  List<Article> _newsList = [];

  /// Init the state machine
  AppStateProvider(BuildContext context){
    final String defaultLocale = Platform.localeName;
    this._deviceLanguage = defaultLocale.substring(0,2);

    loadNews();
  }

  /// Repaint the app
  void refresh() {
    notifyListeners();
  }

  List<Article> getNewsList() {
    return this._newsList;
  }

  void loadNews() async{
    this._newsList = await NewsService().getNews(this._deviceLanguage);
    refresh();
  }

  void loadPreferences(BuildContext context) async {
    if(!_isPreferencesReady) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if(this.loadThemePreferences(prefs, context)){
        this.refresh();
      }
      _isPreferencesReady = true;
    }
  }

}

