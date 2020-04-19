
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile/history/history_list_item.dart';
import 'package:mobile/nav/drawer/menu_drawer.dart';
import 'package:mobile/nav/routes.dart';
import 'package:mobile/nav/top_nav.dart';

class HistoryScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _HistoryScreenState();

}

class _HistoryScreenState extends State<HistoryScreen> {

  List<String> urls = ["asdf", "123"];

  void update(List<String> urls) {
    this.urls = urls;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNav.instance("asdf", context),
      drawer: MenuDrawer(RouteLocations.history),
      body: ListView(
        children: <Widget>[
          for (String url in urls) HistoryItem(url, FontAwesomeIcons.history)
        ],
      ),
    );
  }

}
