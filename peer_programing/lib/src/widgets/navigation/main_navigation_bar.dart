import 'package:flutter/material.dart';
import 'package:peer_programing/src/helper/auth_module.dart';
import 'package:peer_programing/src/theme/color/light_color.dart';

class MainNavigationBar extends StatefulWidget {
  @override
  _MainNavigationBar createState() => _MainNavigationBar();
}

class _MainNavigationBar extends State<MainNavigationBar> {
  final _routeMap = ['/', '/recomended', '/list_selected', '/login'];

  BottomNavigationBarItem _bottomIcons(IconData icon) =>
      BottomNavigationBarItem(icon: Icon(icon), title: Text(""));

  Function _navigate(BuildContext context) => (int index) async {
        var auth = await (new Auth()).getCurrentUser();
        bool logged = auth != null;
        String ruta = this._routeMap[index];
        if (logged && ruta == '/login') {
          ruta = '/user';
        }
        
        Navigator.pushReplacementNamed(context, ruta, arguments: index);
      };

  @override
  Widget build(BuildContext context) {
    final int index = ModalRoute.of(context).settings.arguments;
    return BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: LightColor.purple,
        unselectedItemColor: Colors.grey.shade300,
        type: BottomNavigationBarType.fixed,
        currentIndex: index == null ? 0 : index,
        items: [
          _bottomIcons(Icons.home),
          _bottomIcons(Icons.star_border),
          _bottomIcons(Icons.dns),
          _bottomIcons(Icons.account_circle),
        ],
        onTap: _navigate(context));
  }
}
