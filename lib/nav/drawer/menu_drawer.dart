import 'package:mobile/nav/drawer/drawer_item.dart';
import 'package:mobile/nav/routes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class MenuDrawer extends StatelessWidget {

  final RouteLocations curScreen;
  final String menuTitle = "";

  MenuDrawer(this.curScreen);

  static const List<DrawerItem> _logged_out_items = [
    DrawerItem('Log In', FontAwesomeIcons.signInAlt, RouteLocations.login),

  ];

  static const List<DrawerItem> _logged_in_items = [
    DrawerItem('History', FontAwesomeIcons.history, RouteLocations.settings),
    // TODO: build the history screen 
    // DrawerItem('Settings', FontAwesomeIcons.cog, RouteLocations.settings),
    DrawerItem('Log Out', FontAwesomeIcons.signOutAlt, RouteLocations.logout),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text(menuTitle),
            ),
            ..._logged_in_items.where((i) => i.route != curScreen)
          ],
        ));
  }

}
