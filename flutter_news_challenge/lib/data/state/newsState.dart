import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_news_challenge/data/model/article.dart';
import 'package:flutter_news_challenge/data/services/newsService.dart';

class NewsState {
  List<Article> _newsList = [];
  int _page = 1;
  String _deviceLanguage = Platform.localeName.substring(0,2);
  bool _loading = false;

  List<Article> getNewsList() {
    return this._newsList;
  }

  Future<bool> loadNews(BuildContext context) async{
    if(this._newsList.isEmpty && !_loading) {
      _loading = true;
      this._newsList = await NewsService().getNews(_deviceLanguage, _page);

      if (this._newsList.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Error requesting, try again later',
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(
                  color: Theme
                      .of(context)
                      .errorColor
              ),
            )
        ));

        _loading = false;
        return false;
      }
      _loading = false;
      return true;
    }
    _loading = false;
    return false;
  }

  Future<bool> nextPage() async{
    if(_page > 0 && !_loading){
      _loading = true;
      _page++;
      List<Article> nextNewsList = await NewsService().getNews(_deviceLanguage, _page);

      _loading = false;

      // If reached the end of the API stop with the next requests
      if(nextNewsList.isEmpty){
        this._page = -1;
        return false;
      }
      else {
        this._newsList.addAll(nextNewsList);
        return true;
      }
    }
    return false;
  }
}