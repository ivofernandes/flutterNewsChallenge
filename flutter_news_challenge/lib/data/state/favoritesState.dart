import 'dart:collection';

import 'package:flutter_news_challenge/data/model/article.dart';
import 'package:flutter_news_challenge/data/store/newsStorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesState{

  LinkedHashSet<Article> _favorites = new LinkedHashSet();

  bool isFavorited(Article article){
    return this._favorites.contains(article);
  }

  toogleFavorite(Article article) async{
    if(this.isFavorited(article)){
      this._favorites.remove(article);
      await NewsStorage().removeFavorite(article);
    }else{
      this._favorites.add(article);
      int id = await NewsStorage().addFavorite(article);
      article.id = id;
    }
  }

  List<Article> getAllFavorites(){
    print('num fav: ' +  _favorites.toList().length.toString());
    return _favorites.toList();
  }

  void loadFavorites() async{
    await NewsStorage().initDatabase();

    List<Article> storedFavorites = await NewsStorage().getFavoritesList();

    print('favorites: ' + storedFavorites.length.toString());

    storedFavorites.forEach((article) {
      this._favorites.add(article);
      print('added favorite');
    });
  }

}