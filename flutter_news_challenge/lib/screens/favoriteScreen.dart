import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_news_challenge/components/listArticlesComponent.dart';
import 'package:flutter_news_challenge/data/model/article.dart';
import 'package:flutter_news_challenge/data/state/appStateProvider.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppStateProvider appState =
        Provider.of<AppStateProvider>(context, listen: false);
    List<Article> newsList = appState.getAllFavorites();

    return newsList.isEmpty
        ? Center(
            child: Text('No favorites yet'),
          )
        : SingleChildScrollView(
            child: OrientationBuilder(builder: (context, orientation) {
              return Column(
                children: [
                  ListArticleComponent(newsList),
                ],
              );
            }));
  }
}
