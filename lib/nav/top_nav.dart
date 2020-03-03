import 'package:mobile/nav/routes.dart';
import 'package:flutter/material.dart';

class TopNav {
  static AppBar instance(String title, BuildContext context,
      {searchEnabled: true}) {
    return AppBar(
      title: Text(title),
      actions: <Widget>[
        IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => RouteLocations.home.navigate(context)),
      ],
    );
  }
}
