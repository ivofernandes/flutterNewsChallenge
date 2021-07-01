import 'package:flutter/material.dart';
import 'package:flutter_news_challenge/components/articleSnapshot.dart';
import 'package:flutter_news_challenge/data/model/article.dart';
import 'package:flutter_news_challenge/data/state/appStateProvider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppStateProvider appState =
        Provider.of<AppStateProvider>(context, listen: false);
    List<Article> newsList = appState.getNewsList();

    return newsList.isEmpty
        ? Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            child: OrientationBuilder(builder: (context, orientation) {
              double width = MediaQuery. of(context).size.width;
              bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

              return Container(
                child: Column(
                  children: <Widget>[
                    GridView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: isPortrait ? width : width/2,
                            childAspectRatio: 1.3,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20),
                        itemCount: newsList.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return ArticleSnapshot(
                            imgUrl: newsList[index].urlToImage ?? "",
                            title: newsList[index].title ?? "",
                            publishedAt: newsList[index].publshedAt == null ? '' : DateFormat('dd MMM kk:mm').format(newsList[index].publshedAt!),
                            posturl: newsList[index].articleUrl ?? "",
                          );
                        }),
                  ],
                ),
              );
            }),
          );
  }
}
