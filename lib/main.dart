import "package:http/http.dart" as http;
import 'dart:async';
import 'dart:convert' show json;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:convert';
import 'nav/routes.dart';
import 'package:requests/requests.dart';
import 'tabd_api/client.dart';

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

class OauthLogin {
  String googleToken;
  OauthLogin({this.googleToken});

  Map<String, dynamic> toJson() =>
      {
        'google_token': googleToken,
      };
}

class SignInDemoState extends State<SignInDemo> {
  GoogleSignInAccount _currentUser;
  String _contactText;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) async {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        print(_currentUser);
        GoogleSignInAuthentication authentication = await account.authentication;

        try {
          Response response = await Requests.post('https://tabdextension.com/oauth/verify', json: new OauthLogin(googleToken: authentication.accessToken).toJson());
          final user = await new TabdClient().getUser();
          RouteLocations.history.navigate(context, user);
        } catch (error) {
          print("Error fetching history");
          print(error);
        }
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

  Future<void> _handleTabdSignIn(BuildContext context, String username, String password) async {
    var client = new TabdClient();
    print("Logging you in. Username: ${username}. pw: ${password}");
    final authenticatedUser = await client.login(username, password);
    if (authenticatedUser != null) {
      RouteLocations.history.navigate(context, authenticatedUser);
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
            child: const Text('GOOGLE SIGN IN'),
            onPressed: () => _handleSignIn(context, _currentUser),
          ),
          Form(
            key: Key('login'),
            child: Column(children: <Widget>[
              TextFormField(
                controller: usernameController,
              ),
              TextFormField(
                obscureText: true,
                controller: passwordController,
              ),
              RaisedButton(
                child: const Text('TABD SIGN IN'),
                onPressed: () => _handleTabdSignIn(context, usernameController.text, passwordController.text),
              ),
    ],
    )
          )
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
