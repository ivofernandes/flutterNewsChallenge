import 'package:flutter/material.dart';
import 'package:flutter/src/material/theme_data.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_news_challenge/screens/navigationScreen.dart';
import 'package:flutter_news_challenge/screens/settingsScreen.dart';

import 'navigationState.dart';

class AppStateProvider with ChangeNotifier, NavigationState{
  
  AppStateProvider(BuildContext context){

  }

  ThemeData getTheme() {
    return ThemeData.dark();
  }

  void refresh() {
    notifyListeners();
  }


}

