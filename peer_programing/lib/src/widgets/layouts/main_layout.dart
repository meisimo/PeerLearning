import 'package:flutter/material.dart';
import 'package:peer_programing/src/widgets/layouts/main_header.dart';
import 'package:peer_programing/src/widgets/navigation/main_navigation_bar.dart';


class MainLayout extends StatelessWidget {
  final routeMap = ['/', '/recomended', '/list_selected', '/login'];
  final Widget body;
  final Widget floatingActionButton;

  final String title;
  final Widget headerChild;
  final bool defaultVerticalScroll;
  final bool withBottomNavBar;
  final bool goBack;

  MainLayout({this.body,
      this.title,
      this.headerChild,
      this.defaultVerticalScroll = true,
      this.floatingActionButton,
      this.withBottomNavBar = true,
      this.goBack = false
  });

  BottomNavigationBarItem _bottomIcons(IconData icon) =>
      BottomNavigationBarItem(icon: Icon(icon), title: Text(""));

  Widget _body(Widget body, {bool flex}) => Container(
        child: Column(
          children: <Widget>[
            MainHeader(
              title: this.title,
              child: this.headerChild,
              height: (this.headerChild == null ? 120 : 150),
              goBack: this.goBack,
            ),
            SizedBox(height: 20),
            flex
                ? Flexible(
                    child: body,
                  )
                : body
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: this.withBottomNavBar ? MainNavigationBar() : null,
        body: defaultVerticalScroll
            ? SingleChildScrollView(child: _body(body, flex: false))
            : _body(body, flex: true),
        floatingActionButton: this.floatingActionButton,
      );
  }
}
