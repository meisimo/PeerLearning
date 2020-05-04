import 'package:flutter/material.dart';
import 'package:peer_programing/src/theme/color/light_color.dart';
import 'package:peer_programing/src/widgets/layouts/main_header.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:peer_programing/src/widgets/navigation/main_navigation_bar.dart';

class MainLayout extends StatelessWidget{
  final routeMap = ['/','/recomended', '/list_selected', '/login'];
  final Widget body;
  final FloatingActionButton floatingActionButton;

  final String title;
  final Widget headerChild;
  final bool defaultVerticalScroll;
  final bool withBottomNavBar;

  MainLayout({this.body, this.title, this.headerChild, this.defaultVerticalScroll=true, 
    this.floatingActionButton, this.withBottomNavBar = true});

  BottomNavigationBarItem _bottomIcons(IconData icon) =>
    BottomNavigationBarItem(icon: Icon(icon), title: Text(""));

  Widget _body(Widget body) =>
    Container(
          child: Column(
            children: <Widget>[
              MainHeader( 
                title: this.title,
                child: this.headerChild,
                height: (this.headerChild == null ? 120: 150),
              ),
              SizedBox(height: 20),
              this.body,
            ],
          ),
        );

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      bottomNavigationBar: this.withBottomNavBar ? MainNavigationBar() : null,
      body: defaultVerticalScroll ?  SingleChildScrollView(child: _body(body)) : _body(body),
      floatingActionButton: this.floatingActionButton,
    );
}