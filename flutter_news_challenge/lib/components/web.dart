import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Web extends StatefulWidget{

  final String title;
  final String url;

  Web._(this.title, this.url);

  @override
  _WebState createState() => _WebState();

  static openView(BuildContext context, String title, String url) {
    if (kIsWeb) {
      launchLink(context, url);
    } else {
      Navigator.of(context).push(
          MaterialPageRoute<void>(builder: (BuildContext context) => Web._(title, url)));
    }
  }
  static void launchLink(BuildContext context, String url) async {
    if(await canLaunch(url)){
      launch(url);
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error on trying to open url',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                color: Theme.of(context).errorColor
            ),
          )
      ));
    }
  }
}

class _WebState extends State<Web> {

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid){
      WebView.platform = SurfaceAndroidWebView();
    }
  }
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
          actions: <Widget>[
            NavigationControls(widget.url, _controller.future)
          ],
        ),
        // We're using a Builder here so we have a context that is below the Scaffold
        // to allow calling Scaffold.of(context) so we can show a snackbar.
        body: Builder(builder: (BuildContext context) {
          return WebView(
            initialUrl: widget.url,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
            javascriptChannels: <JavascriptChannel>{
              _toasterJavascriptChannel(context),
            },
            navigationDelegate: (NavigationRequest request) {
              if (request.url.startsWith('https://www.youtube.com/')) {
                print('blocking navigation to $request}');
                return NavigationDecision.prevent;
              }
              print('allowing navigation to $request');
              return NavigationDecision.navigate;
            },
            onPageStarted: (String url) {
              print('Page started loading: $url');
            },
            onPageFinished: (String url) {
              print('Page finished loading: $url');
            },
            gestureNavigationEnabled: true,
          );
        })
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          // ignore: deprecated_member_use
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }
}

class NavigationControls extends StatelessWidget {

  final String url;
  final Future<WebViewController> _webViewControllerFuture;

  const NavigationControls(this.url, this._webViewControllerFuture)
      : assert(_webViewControllerFuture != null);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _webViewControllerFuture,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        final bool webViewReady =
            snapshot.connectionState == ConnectionState.done;
        final WebViewController? controller = snapshot.data;
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