import 'package:mobile/nav/routes.dart';
import 'package:mobile/theme.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  static const title = 'Flutter Demo Home Page';


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: FloraTheme.instance(),
      initialRoute: RouteLocations.home.name,
      routes: Routes.routeMap,
      supportedLocales: [
        Locale('en')
      ],
    );
  }

}
