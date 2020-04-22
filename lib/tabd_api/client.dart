import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile/history/history_list_item.dart';
import 'package:mobile/nav/drawer/menu_drawer.dart';
import 'package:mobile/nav/routes.dart';
import 'package:mobile/nav/top_nav.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/user/user.dart';
import 'package:requests/requests.dart';

class Tab {
  final String url;

  Tab({this.url});

  factory Tab.fromJson(Map<String, dynamic> json) {
    return Tab(
      url: json['url'],
    );
  }

  String toString() {
    return "Tab{url=$url}";
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

  String toString() {
    return "TabHistory{tabs=$tabs}";
  }
}

class TabdClient {
  Future<User> login(String username, String password) async {
    print ("Logging you in!");
    Response response = await Requests.post('https://tabdextension.com/user/login',
        body: new Map<String, dynamic>.from(
            {"login-username": username.trim(), "login-password": password.trim()}),
        bodyEncoding: RequestBodyEncoding.FormURLEncoded);
    final String receivedUsername = response.json()['username'];
    if (receivedUsername != null) {
      return User(username: receivedUsername);
    } else {
      return null;
    }
  }

  Future<User> getUser() async {
    Response response = await Requests.get('https://tabdextension.com/user/logged_in');
    final String receivedUsername = response.json()['username'];
    if (receivedUsername != null) {
      return User(username: receivedUsername);
    } else {
      return null;
    }
  }

  Future<TabHistory> getHistory(int page, String query) async {
    print("Getting history!");
    Response response = await Requests.post(
        'https://tabdextension.com/tabs/history',
        body: new Map<String, dynamic>.from({"section_num": page}),
        bodyEncoding: RequestBodyEncoding.FormURLEncoded);
      print("Request done!");

    if (response.statusCode == 200) {
      var tabsJson = response.json()['tabs'];
      List<Tab> tabList = [];
      for (var i = 0; i < tabsJson.length; i++) {
        var tab = new Tab(url: tabsJson[i]['url']);
        tabList.add(tab);
      }
      TabHistory history = new TabHistory(tabs: tabList);
      print("Done getting history!");
      print(history);
      return history;
    } else {
      throw new Exception("that didnt work, asshole.");
    }
  }
}
