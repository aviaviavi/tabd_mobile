
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile/history/history_list_item.dart';
import 'package:mobile/nav/drawer/menu_drawer.dart';
import 'package:mobile/nav/routes.dart';
import 'package:mobile/nav/top_nav.dart';
import 'package:mobile/user/user.dart';
import 'package:requests/requests.dart';

class HistoryScreen extends StatefulWidget {

  User currentUser;

  HistoryScreen(this.currentUser);

  @override
  State<StatefulWidget> createState() => _HistoryScreenState(currentUser);

}

class Tab {
  final String url;

  Tab({this.url});

  factory Tab.fromJson(Map<String, dynamic> json) {
    return Tab(
      url: json['url'],
    );
  }
}

class TabHistory {
  final List<Tab> tabs;

  TabHistory({this.tabs});

  factory TabHistory.fromJson(Map<String, dynamic> json) {
    return TabHistory(
      tabs: json['tabs'],
    );
  }
}

class _HistoryScreenState extends State<HistoryScreen> {

  User currentUser;
  TabHistory tabs = new TabHistory(tabs: []);

  _HistoryScreenState(this.currentUser);

  void update(TabHistory tabs, User currentUser) {
    setState(() {
      this.tabs = tabs;
      this.currentUser = currentUser;
    });
  }

  Future<void> fetchHistory() async {
    try {
      Response response = await Requests.post('https://tabdextension.com/tabs/history', body: new Map<String, dynamic>.from({"section_num": 0}), bodyEncoding: RequestBodyEncoding.FormURLEncoded);

      if (response.statusCode == 200) {
        var tabsJson = response.json()['tabs'];
        List<Tab> tabList = [];
        for (var i = 0; i < tabsJson.length; i++) {
          var tab = new Tab(url: tabsJson[i]['url']);
          tabList.add(tab);
        }
        TabHistory history = new TabHistory(tabs: tabList);
        print(history);
        update(history, this.currentUser);
      } else {
        print(response.statusCode);
        print(response.json());
      }
    } catch (err) {
      print(err);
    }

    return;
  }

  @override
  Widget build(BuildContext context) {
    final User currentUser = ModalRoute.of(context).settings.arguments;
    String displayName = currentUser == null ? 'No name' : currentUser.username;
    this.fetchHistory();
    return Scaffold(
      appBar: TopNav.instance("Welcome " + displayName, context),
      drawer: MenuDrawer(RouteLocations.history),
      body: ListView(
        children: <Widget>[
          for (Tab tab in tabs.tabs) HistoryItem(tab.url, FontAwesomeIcons.history)
        ],
      ),
    );
  }

}
