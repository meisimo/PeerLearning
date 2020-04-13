import 'package:flutter/material.dart';

import 'package:peer_programing/src/pages/home_page.dart';
import 'package:peer_programing/src/pages/recomended_page.dart';
import 'package:peer_programing/src/pages/lists_page.dart';
import 'package:peer_programing/src/pages/selected_mentoring.dart';
import 'package:peer_programing/src/pages/user_page.dart';
import 'package:peer_programing/src/pages/login_page.dart';


class Routes{
  static final initialRoute = '/';
  static final routes = {
    '/': (BuildContext context) => new HomePage(),
    '/recomended': (BuildContext context) => new RecomendedPage(),
    '/list_selected': (BuildContext context) => new SelectedMentorings(),
    '/list_proposals': (BuildContext context) => new ListPage(),
    '/create_mentoring': (BuildContext context) => new RecomendedPage(),
    '/user': (BuildContext context) => new UserPage(),
    '/login': (BuildContext context) => new LoginPage()
  };
}