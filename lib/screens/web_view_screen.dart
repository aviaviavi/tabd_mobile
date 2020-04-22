import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile/nav/drawer/menu_drawer.dart';
import 'package:mobile/nav/top_nav.dart';
import 'package:mobile/nav/routes.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  String url;

  WebViewScreen({this.url});

  @override
  _WebViewScreenState createState() => _WebViewScreenState(this.url);
}

class _WebViewScreenState extends State<WebViewScreen> {
  String targetUrl;
  WebViewController wvc;

  _WebViewScreenState(this.targetUrl);

  void update(String t) {
    setState(() {
      targetUrl = t;
      wvc?.loadUrl(t);
    });
  }

  @override
  Widget build(BuildContext context) {
    final targetUrl = ModalRoute.of(context).settings.arguments;

    if (wvc == null) {
      this.update(targetUrl);
    }
    
    return Scaffold(
        appBar: TopNav.instance(targetUrl != null ? targetUrl : "https://tabdextension.com", context),
        drawer: MenuDrawer(RouteLocations.home),
        body: Stack(
          children: <Widget>[
            WebView(
              onWebViewCreated: (controller) {
                wvc = controller;
              },
              initialUrl: targetUrl != null ? targetUrl : "https://tabdextension.com",
            ),
          ],
        )


    );
  }

}
