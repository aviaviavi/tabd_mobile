import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile/nav/drawer/menu_drawer.dart';
import 'package:mobile/nav/top_nav.dart';
import 'package:mobile/nav/routes.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreen extends StatefulWidget {
  final String title;

  HomeScreen({Key key, this.title}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _asdf = 'http://tabdextension.com';
  WebViewController wvc;

  void update(String t) {
    setState(() {
      _asdf = t;
      wvc?.loadUrl(_asdf);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNav.instance(_asdf, context),
      drawer: MenuDrawer(RouteLocations.home),
      body: Stack(
        children: <Widget>[
        WebView(
          onWebViewCreated: (controller) {
            wvc = controller;
          },
        initialUrl: _asdf,
      ),
        IconButton(
          icon: new Icon(FontAwesomeIcons.podcast),
          iconSize: 100,
          onPressed: () => RouteLocations.history.navigate(context, null),
        ),
        ],
      )


    );
  }

}
