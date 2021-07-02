import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_news_challenge/data/model/article.dart';

class NewsService{

  static final NewsService _singleton = NewsService._internal();
  factory NewsService() {
    return _singleton;
  }
  NewsService._internal();

  static const String BASE_URL = 'newsapi.org';
  static const String API_KEY = 'e9f236f020e5427aa5f6b1ff104e955e';

  static const String TOP_HEADLINES = '/v2/top-headlines';

  Future<List<Article>> getNews(String language) async{

    List<Article> news = [];
    // Example url:
    // https://newsapi.org/v2/top-headlines?country=us&sortBy=publishedAt&language=en&apiKey=e9f236f020e5427aa5f6b1ff104e955e
    var response = await http.get(Uri.https(BASE_URL, TOP_HEADLINES, {
    'pageSize': '100',
    'sortBy': 'publishedAt',
    'language': language,
    'apiKey': API_KEY
    }));

    if(response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData['status'] == 'ok') {
        jsonData['articles'].forEach((element) {
          if (element['urlToImage'] != null && element['description'] != null) {
            Article article = Article(
              title: element['title'],
              urlToImage: element['urlToImage'],
              publshedAt: DateTime.parse(element['publishedAt']),
              articleUrl: element['url'],
            );
            news.add(article);
          }
        });
      }
    }

    return news;
  }

}