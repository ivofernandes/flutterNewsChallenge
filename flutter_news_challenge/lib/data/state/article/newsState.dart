import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_news_challenge/data/model/article.dart';
import 'package:flutter_news_challenge/data/services/newsService.dart';
import 'package:provider/provider.dart';

import '../appStateProvider.dart';

class NewsState {
  List<Article> _newsList = [];
  int _page = 1;
  String _deviceLanguage = Platform.localeName.substring(0,2);
  bool _initialLoading = false;
  bool _loadingNext = false;

  List<Article> getNewsList() {
    return this._newsList;
  }

  Future<bool> loadNews(BuildContext context, bool hasInternetConnection) async{
    if(this._newsList.isEmpty && !_initialLoading) {
      this._initialLoading = true;

      if(hasInternetConnection) {
        this._newsList =
        await NewsService().getNews(_deviceLanguage, 1).onError(
                (error, stackTrace) async =>
            this._newsList = await NewsService().getOfflineNews());
      }else{
        this._newsList = await NewsService().getOfflineNews();
      }
      if (this._newsList.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Error getting news, try again later',
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

        this._initialLoading = false;
        return false;
      }
      this._initialLoading = false;
      return true;
    }
    return false;
  }

  Future<bool> nextPage(BuildContext context) async{
    if(this._page > 0 && !_loadingNext){
      this._loadingNext = true;
      // Repaint when the main thread
      AppStateProvider appState =
      Provider.of<AppStateProvider>(context, listen: false);
      appState.refresh();

      this._page++;
      List<Article> nextNewsList = await NewsService().getNews(_deviceLanguage, _page);

      this._loadingNext = false;

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

  bool isLoadingNext(){
    return this._loadingNext;
  }
}