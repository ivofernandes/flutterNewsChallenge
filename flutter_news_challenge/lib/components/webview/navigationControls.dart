import 'package:flutter/material.dart';
import 'package:flutter_news_challenge/components/webview/web.dart';
import 'package:share_plus/share_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NavigationControls extends StatelessWidget {

  final String url;
  final Future<WebViewController> _webViewControllerFuture;

  const NavigationControls(this.url, this._webViewControllerFuture);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _webViewControllerFuture,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        return Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.open_in_browser),
              onPressed: () => Web.launchLink(context, url),
            ),

            IconButton(
              icon: const Icon(Icons.share),
              onPressed: () => Share.share(this.url),
            ),
          ],

        );
      },
    );
  }
}