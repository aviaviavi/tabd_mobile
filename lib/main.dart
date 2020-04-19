import "package:http/http.dart" as http;
import 'dart:async';
import 'dart:convert' show json;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'nav/routes.dart';
import 'nav/routes.dart';
import 'nav/routes.dart';
import 'nav/routes.dart';

//void main() => runApp(MyApp());
//
//class MyApp extends StatelessWidget {
//
//  static const title = 'Flutter Demo Home Page';
//
//
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      theme: FloraTheme.instance(),
//      initialRoute: RouteLocations.home.name,
//      routes: Routes.routeMap,
//      supportedLocales: [
//        Locale('en')
//      ],
//    );
//  }
//
//}


GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'profile',
    'openid',
  ],
);

void main() {
  runApp(
    MaterialApp(
      title: 'Google Sign In',
      home: SignInDemo(),
      routes: Routes.routeMap,
    ),
  );
}

class SignInDemo extends StatefulWidget {
  @override
  State createState() => SignInDemoState();
}

class SignInDemoState extends State<SignInDemo> {
  GoogleSignInAccount _currentUser;
  String _contactText;

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
        print(account);
      });
      if (_currentUser != null) {
        print("We got a user!");
        print(_currentUser);
        RouteLocations.history.navigate(context, _currentUser);
      }
    });
    _googleSignIn.signInSilently();
  }

  Future<void> _handleSignIn(BuildContext context, GoogleSignInAccount currentUser) async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  Widget _buildBody(BuildContext context) {
    if (_currentUser != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ListTile(
            leading: GoogleUserCircleAvatar(
              identity: _currentUser,
            ),
            title: Text(_currentUser.displayName ?? ''),
            subtitle: Text(_currentUser.email ?? ''),
          ),
          const Text("Signed in successfully."),
          Text(_contactText ?? ''),
          RaisedButton(
            child: const Text('SIGN OUT'),
            onPressed: _handleSignOut,
          ),
          RaisedButton(
            child: const Text('REFRESH'),
            onPressed: (){},
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          const Text("You are not currently signed in."),
          RaisedButton(
            child: const Text('SIGN IN'),
            onPressed: () => _handleSignIn(context, _currentUser),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Google Sign In'),
        ),
        body: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: _buildBody(context),
        ));
  }
}
