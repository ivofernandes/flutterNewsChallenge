import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_news_challenge/data/model/article.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsService {
  static final NewsService _singleton = NewsService._internal();

  factory NewsService() {
    return _singleton;
  }

  NewsService._internal();

  static const String BASE_URL = 'newsapi.org';
  static const String API_KEY = 'e9f236f020e5427aa5f6b1ff104e955e';
  static const String TOP_HEADLINES = '/v2/top-headlines';

  static const String CACHE_JSON_NEWS = 'CACHE_JSON_NEWS';

  Future<List<Article>> getNews(String language, int page) async {
    // Example url:
    // https://newsapi.org/v2/top-headlines?country=us&sortBy=publishedAt&language=en&apiKey=e9f236f020e5427aa5f6b1ff104e955e
    var response = await http
        .get(Uri.https(BASE_URL, TOP_HEADLINES, {
      'pageSize': '100',
      'sortBy': 'publishedAt',
      'language': language,
      'apiKey': API_KEY,
      'page': page.toString()
    })).timeout(Duration(milliseconds: 2000), onTimeout: () {
      throw TimeoutException('Timeout');
    });

    saveOfflineNews(response.body);
    if (response.statusCode == 200) {
      return articlesFromJson(response.body);
    }

    return [];
  }

  Future<void> saveOfflineNews(String json) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString(CACHE_JSON_NEWS,json);
  }

  Future<List<Article>> getOfflineNews() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? cacheJson = prefs.getString(CACHE_JSON_NEWS);

    if(cacheJson != null) {
      return articlesFromJson(cacheJson);
    }else{
      return [];
    }
  }

  List<Article> articlesFromJson(String json) {

    List<Article> news = [];
    var jsonData = jsonDecode(json);
    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          Article article = Article(
            title: element['title'],
            urlToImage: element['urlToImage'],
            publishedAt: DateTime.parse(element['publishedAt']),
            articleUrl: element['url'],
          );
          news.add(article);
        }
      });
    }
    return news;
  }
}
