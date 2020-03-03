
import 'package:mobile/nav/routes.dart';
import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {

  final String label;
  final IconData icon;
  final RouteLocations route;

  const DrawerItem(this.label, this.icon, this.route);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      onTap: () => route.navigate(context),
    );
  }

}