import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_challenge/components/web.dart';

class ArticleSnapshot extends StatelessWidget {
  final String imgUrl;
  final String title;
  final String publishedAt;
  final String posturl;

  const ArticleSnapshot({
    required this.imgUrl,
    required this.publishedAt,
    required this.title,
    required this.posturl
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Web.openView(context, this.title, this.posturl);
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
                    SizedBox(height: 10),
                    Text(
                      title,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(height: 5),
                    Text(publishedAt)
                  ],
                ),
              ),
            ),
          )),
    );
  }
}