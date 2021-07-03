import 'package:flutter_news_challenge/data/model/article.dart';
import 'package:flutter_news_challenge/data/store/sembastDatabase.dart';
import 'package:sembast/sembast.dart';

class NewsStorage with SembastDatabase{

  static final NewsStorage _singleton = NewsStorage._internal();
  factory NewsStorage() {
    return _singleton;
  }
  NewsStorage._internal();

  static final String STORE_FAVORITES = 'favorites';

  /// Get the favorites available in the device
  Future<List<Article>> getFavoritesList() async{
    var store = intMapStoreFactory.store(STORE_FAVORITES);
    var data = await store.find(getDatabase(), finder: Finder());

    List<Article> favorites = [];

    data.forEach((snapshot) {
      final Article article = Article.fromMap(snapshot.value);
      // An ID is a key of a record from the database.
      article.id = snapshot.key;
      favorites.add(article);
    });

    return favorites;
  }

  removeFavorite(Article article) async {
    var store = intMapStoreFactory.store(STORE_FAVORITES);

    int deleted = await store.delete(getDatabase(),
        finder: Finder(filter: Filter.byKey(article.id)));

    print('deleted ' + deleted.toString());
  }

  Future<int> addFavorite(Article article) async{
    var store = intMapStoreFactory.store(STORE_FAVORITES);

    int key = await store.add(getDatabase(), article.toMap());

    return key;
  }

}
