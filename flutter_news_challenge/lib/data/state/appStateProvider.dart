import 'package:flutter/material.dart';
import 'package:flutter/src/material/theme_data.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_news_challenge/data/model/article.dart';
import 'package:flutter_news_challenge/data/services/newsService.dart';
import 'package:flutter_news_challenge/screens/navigationScreen.dart';
import 'package:flutter_news_challenge/screens/settingsScreen.dart';

import 'navigationState.dart';

class AppStateProvider with ChangeNotifier, NavigationState{
  
  AppStateProvider(BuildContext context){
    // Do not await for loading as we have the circular loading spinner
    loadNews();
  }

  ThemeData getTheme() {
    return ThemeData.dark();
  }

  void refresh() {
    notifyListeners();
  }

  List<Article> _newsList = [];

  List<Article> getNewsList() {
    return this._newsList;
  }

  void loadNews() async{
    this._newsList = await NewsService().getNews();
    refresh();
  }


}

