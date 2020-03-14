import 'package:flutter/material.dart';

class Routes{
  static final initialRoute = '/';
  static final routes = {
    '/': (BuildContext context) => new Text('main'),
    '/login': (BuildContext context) => new Text('login'),
  };
}