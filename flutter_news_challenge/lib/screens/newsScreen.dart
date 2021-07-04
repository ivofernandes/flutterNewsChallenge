import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_challenge/components/article/listArticlesComponent.dart';
import 'package:flutter_news_challenge/data/model/article.dart';
import 'package:flutter_news_challenge/data/state/appStateProvider.dart';
import 'package:provider/provider.dart';

class NewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppStateProvider appState =
        Provider.of<AppStateProvider>(context, listen: false);
    List<Article> newsList = appState.getNewsList();

    final ScrollController _scrollController = ScrollController();

    return newsList.isEmpty
        ? Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            controller: _scrollController,
            child: OrientationBuilder(builder: (context, orientation) {
              _scrollController.addListener(() {
                var remaining = _scrollController.position.maxScrollExtent -
                    _scrollController.position.pixels;
                if (remaining < 1500) {
                  appState.nextPage(context).then((hasNextValue) {
                    if (hasNextValue) {
                      appState.refresh();
                    }
                  });
                }
              });

              return Column(
                children: [
                  ListArticleComponent(appState.getNewsList()),
                  appState.isLoadingNext() ? Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: CircularProgressIndicator(),
                  ) : Container()
                ],
              );
        })
    );
  }
}
