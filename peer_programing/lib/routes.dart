import 'package:flutter/material.dart';
import 'package:peer_programing/src/pages/detalle.dart';

import 'package:peer_programing/src/pages/home_page.dart';
import 'package:peer_programing/src/pages/recomended_page.dart';
import 'package:peer_programing/src/pages/lists_page.dart';
import 'package:peer_programing/src/pages/user_page.dart';


class Routes{
  static final initialRoute = '/';
  static final routes = {
    '/': (BuildContext context) => new HomePage(),
    '/recomended': (BuildContext context) => new RecomendedPage(),
    '/list_selected': (BuildContext context) => new ListPage(),
    '/list_proposals': (BuildContext context) => new Detalle(),
    '/user': (BuildContext context) => new UserPage(),
  };
}