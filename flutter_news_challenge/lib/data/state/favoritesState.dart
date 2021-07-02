import 'dart:collection';

import 'package:flutter_news_challenge/data/model/article.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesState{

  LinkedHashSet<Article> _favorites = new LinkedHashSet();

  bool isFavorited(Article article){
    return this._favorites.contains(article);
  }

  toogleFavorite(Article article) {
    if(this.isFavorited(article)){
      this._favorites.remove(article);
    }else{
      this._favorites.add(article);
    }
  }

  List<Article> getAllFavorites(){
    return _favorites.toList();
  }

  setFavorites(LinkedHashSet<Article> articles){
    this._favorites = articles;
  }

  void loadFavorites(SharedPreferences prefs) {
    //TODO load from local storage
  }

}