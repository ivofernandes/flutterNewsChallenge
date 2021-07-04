
import 'package:flutter/material.dart';
import 'package:flutter_news_challenge/data/model/article.dart';
import 'package:flutter_news_challenge/data/state/appStateProvider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

/// This article footer renders the title date and favorite button
/// and all is in a stack so the favorite button
/// can override a bit of the title space to make it bigger and more clickable
class ArticleFooter extends StatelessWidget {
  final Article article;

  const ArticleFooter(this.article);

  @override
  Widget build(BuildContext context) {
    AppStateProvider appState =
    Provider.of<AppStateProvider>(context, listen: false);

    String title = article.title ?? "";
    String publishedAt = article.publishedAt == null ? '' : DateFormat('dd MMM kk:mm').format(article.publishedAt!);

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomRight,
      children: [
        Column(
          children: [
            SizedBox(height: 10),
            SizedBox(
              height:60,
              child: Text(
                title,
                maxLines: 2,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(publishedAt)
              ],
            )
          ],
        ),
        Positioned(
          bottom: -20,
          right:-10,
          child: GestureDetector(
              onTap:(){
                appState.toogleFavorite(article);
                appState.refresh();
              },
              child: Container(
                // This hack of zero opacity color is just for the container,
                // that covers the button with a padding, to be really clickable
                // ---->
                color: Colors.green.withOpacity(0.0),
                // <-----
                padding: const EdgeInsets.only(left: 50.0, top: 50, bottom:20, right:20),
                child: Icon(
                  Icons.favorite,
                  color: appState.isFavorited(article) ? Colors.red : null,
                ),
              )
          ),
        )
      ],
    );
  }
}