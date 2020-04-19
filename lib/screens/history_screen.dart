
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile/history/history_list_item.dart';
import 'package:mobile/nav/drawer/menu_drawer.dart';
import 'package:mobile/nav/routes.dart';
import 'package:mobile/nav/top_nav.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HistoryScreen extends StatefulWidget {

  GoogleSignInAccount currentUser;

  HistoryScreen(this.currentUser);

  @override
  State<StatefulWidget> createState() => _HistoryScreenState(currentUser);

}

class _HistoryScreenState extends State<HistoryScreen> {

  GoogleSignInAccount currentUser;
  List<String> urls = ["asdf", "123"];

  _HistoryScreenState(this.currentUser);

  void update(List<String> urls, GoogleSignInAccount currentUser) {
    this.urls = urls;
    this.currentUser = currentUser;
  }

  @override
  Widget build(BuildContext context) {
    final GoogleSignInAccount currentUser = ModalRoute.of(context).settings.arguments;
    String displayName = currentUser == null ? 'No name' : currentUser.displayName;
    return Scaffold(
      appBar: TopNav.instance("Welcome " + displayName, context),
      drawer: MenuDrawer(RouteLocations.history),
      body: ListView(
        children: <Widget>[
          for (String url in urls) HistoryItem(url, FontAwesomeIcons.history)
        ],
      ),
    );
  }

}
