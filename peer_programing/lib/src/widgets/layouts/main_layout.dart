import 'package:flutter/material.dart';
import 'package:peer_programing/src/utils/connection.dart';
import 'package:peer_programing/src/widgets/circular_loading.dart';
import 'package:peer_programing/src/widgets/layouts/main_header.dart';
import 'package:peer_programing/src/widgets/navigation/main_navigation_bar.dart';
import 'package:peer_programing/src/widgets/tarjetas/not_connected.dart';

class MainLayout extends StatefulWidget {
  final Widget body;
  final FloatingActionButton floatingActionButton;

  final String title;
  final Widget headerChild;
  final bool defaultVerticalScroll;
  final bool withBottomNavBar;
  final bool needConnection;

  MainLayout(
      {this.body,
      this.title,
      this.headerChild,
      this.defaultVerticalScroll = true,
      this.floatingActionButton,
      this.withBottomNavBar = true,
      this.needConnection = true});

  @override
  MainLayoutState createState() => new MainLayoutState(
        body: this.body,
        title: this.title,
        headerChild: this.headerChild,
        defaultVerticalScroll: this.defaultVerticalScroll,
        floatingActionButton: this.floatingActionButton,
        withBottomNavBar: this.withBottomNavBar,
        needConnection: this.needConnection,
      );
}

class MainLayoutState extends State<MainLayout> {
  final routeMap = ['/', '/recomended', '/list_selected', '/login'];
  final Widget body;
  final FloatingActionButton floatingActionButton;

  final String title;
  final Widget headerChild;
  final bool defaultVerticalScroll;
  final bool withBottomNavBar;
  final bool needConnection;

  bool checkingConnection;
  bool connected;

  MainLayoutState(
      {this.body,
      this.title,
      this.headerChild,
      this.defaultVerticalScroll = true,
      this.floatingActionButton,
      this.withBottomNavBar = true,
      this.needConnection = true})
      : this.checkingConnection = needConnection;

  BottomNavigationBarItem _bottomIcons(IconData icon) =>
      BottomNavigationBarItem(icon: Icon(icon), title: Text(""));

  void _checkConnectivity(context) {
    checkConnectivity().then((connected) {
      if (!connected) {
        showDialog(
            context: context,
            child: NotConnectedCard(tryToReconnect: () {
              Navigator.of(context).pop();
              setState(() => this.checkingConnection = true);
            }));
      }
      setState(() {
        this.checkingConnection = false;
        this.connected = connected;
      });
    });
  }

  Widget _body(Widget body, {bool flex}) => Container(
        child: Column(
          children: <Widget>[
            MainHeader(
              title: this.title,
              child: this.headerChild,
              height: (this.headerChild == null ? 120 : 150),
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

  Scaffold _scaffold() => Scaffold(
        bottomNavigationBar: this.withBottomNavBar ? MainNavigationBar() : null,
        body: defaultVerticalScroll
            ? SingleChildScrollView(child: _body(body, flex: false))
            : _body(body, flex: true),
        floatingActionButton: this.floatingActionButton,
      );

  Scaffold _emptyScaffold(child) => Scaffold(
        bottomNavigationBar: this.withBottomNavBar ? MainNavigationBar() : null,
        body: _body(
          Padding(padding: EdgeInsets.all(100), child: child),
          flex: true,
        ),
        floatingActionButton: this.floatingActionButton,
      );

  @override
  Widget build(BuildContext context) {
    if (needConnection) {
      if (checkingConnection) {
        _checkConnectivity(context);
        return _emptyScaffold(CircularLoading());
      } else {
        if (connected) {
          return _scaffold();
        } else {
          return _emptyScaffold(Text(
            "No hay internet   :(",
            style: TextStyle(
              fontSize: 20,
            ),
          ));
        }
      }
    }
    return _scaffold();
  }
}
