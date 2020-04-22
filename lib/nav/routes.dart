import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobile/main.dart';
import 'package:mobile/screens/history_screen.dart';
import 'package:mobile/screens/home_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile/user/user.dart';

enum RouteLocations {
  history,
  home,
  login,
  logout,
  settings,
}

typedef RouteFunc = Widget Function(BuildContext ctx);

extension Routes on RouteLocations {
  static String nameFor(RouteLocations v) => '/' + describeEnum(v);

  String get name => nameFor(this);

  void navigate(BuildContext context, User currentUser) =>
      Navigator.pushNamed(context, this.name, arguments: currentUser);

  static Map<String, RouteFunc> routeMap = {
    nameFor(RouteLocations.home): (ctx) => HomeScreen(title: 'Tabd Mobile!'),
    nameFor(RouteLocations.history): (ctx) => HistoryScreen(null),
  };
}
