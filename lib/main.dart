import "package:http/http.dart" as http;
import 'dart:async';
import 'dart:convert' show json;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:convert';
import 'nav/routes.dart';
import 'package:requests/requests.dart';
import 'tabd_api/client.dart';
import 'screens/sign_in_demo.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Sign in to Tabd',
      home: SignInDemo(),
      routes: Routes.routeMap,
    ),
  );
}

