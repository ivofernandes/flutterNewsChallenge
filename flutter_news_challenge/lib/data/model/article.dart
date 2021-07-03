class Article{

  String? title;
  String? urlToImage;
  DateTime? publishedAt;
  String? articleUrl;
  int? id;

  Article({
     this.title, this.publishedAt,
     this.urlToImage,  this.articleUrl
  });

  @override
  bool operator ==(Object other) => other is Article && other.articleUrl == articleUrl;

  @override
  int get hashCode => articleUrl.hashCode;

  static Article fromMap(Map<String, dynamic> map) {

    DateTime publishedAt = DateTime.fromMillisecondsSinceEpoch(map['publishedAt']);

    return Article(
      title: map['title'].toString(),
      publishedAt: publishedAt,
      urlToImage: map['urlToImage'].toString(),
      articleUrl: map['articleUrl'].toString()
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};

    map['title'] = title;
    map['urlToImage'] = urlToImage;
    map['publishedAt'] = publishedAt?.millisecondsSinceEpoch;
    map['articleUrl'] = articleUrl;

    return map;

  }

}