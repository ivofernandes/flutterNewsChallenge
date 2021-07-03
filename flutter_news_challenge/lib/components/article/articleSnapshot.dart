import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_challenge/components/webview/web.dart';
import 'package:flutter_news_challenge/data/model/article.dart';
import 'package:flutter_news_challenge/data/state/appStateProvider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'articleFooter.dart';

class ArticleSnapshot extends StatelessWidget {
  final Article article;

  const ArticleSnapshot(this.article);

  @override
  Widget build(BuildContext context) {

    String imgUrl = article.urlToImage ?? "";
    String title = article.title ?? "";
    String articleUrl = article.articleUrl ?? "";

    return GestureDetector(
      onTap: (){
        Web.openView(context, title, articleUrl);
      },
      child: Container(
          margin: EdgeInsets.only(left:5,right:5, top:5),
          width: MediaQuery.of(context).size.width,
          child: Card(
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
            elevation: 10,
            child: Container(
              margin: EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(10)
                    )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: imgUrl,
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover),
                            ),
                          ),
                          placeholder: (context, url) => Image(
                            image: AssetImage('assets/images/imageLoadingPlaceholder.png')
                          ),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        )
                    ),
                    ArticleFooter(article)
                  ],
                ),
              ),
            ),
          )),
    );
  }
}