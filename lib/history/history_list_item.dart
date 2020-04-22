
import 'package:flutter/material.dart';
import 'package:mobile/nav/routes.dart';

class HistoryItem extends StatelessWidget {

  final String url;
  final IconData icon;

  const HistoryItem(this.url, this.icon);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(url),
      onTap: () => RouteLocations.web_view.navigate(context, url)
    );
  }

}
