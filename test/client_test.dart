// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:async';

import 'package:mobile/main.dart';
import 'package:mobile/tabd_api/client.dart';

void main() {
  test("It doesnt work", () async { 
    TabdClient c = TabdClient(); 
    await c.login("<YOUR USERNAME>", "<YOUR PASSWORD>"); 
    TabHistory h = await c.getHistory(0, null); 
    print(h);
    expect(true, equals(false));
    throw new Exception(h.toString());
  });

}
