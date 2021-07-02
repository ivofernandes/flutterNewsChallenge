import 'package:flutter/material.dart';
import 'package:flutter_news_challenge/components/articleSnapshot.dart';
import 'package:flutter_news_challenge/data/model/article.dart';

class ListArticleComponent extends StatelessWidget {
  final List<Article> articlesList;

  const ListArticleComponent(this.articlesList);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery. of(context).size.width;
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return GridView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        scrollDirection: Axis.vertical,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: isPortrait ? width : width/2,
            childAspectRatio: 1.25,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemCount: articlesList.length,
        itemBuilder: (BuildContext ctx, index) {
          return ArticleSnapshot(articlesList[index]);
        });
  }
}
