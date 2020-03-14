import 'package:flutter/material.dart';
import 'package:peer_programing/src/theme/color/light_color.dart';

class MainLayout extends StatelessWidget{
  final routeMap = ['/','/recomended', '/list', '/user'];
  final Widget body;

  MainLayout({this.body});

  BottomNavigationBarItem _bottomIcons(IconData icon) {
    return BottomNavigationBarItem(icon: Icon(icon), title: Text(""));
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: LightColor.purple,
          unselectedItemColor: Colors.grey.shade300,
          type: BottomNavigationBarType.fixed,
          currentIndex: 0,
          items: [
            _bottomIcons(Icons.home),
            _bottomIcons(Icons.star_border),
            _bottomIcons(Icons.book),
            _bottomIcons(Icons.person),
          ],
          onTap: (index) {
            Navigator.pushReplacementNamed(context, this.routeMap[index]);
          },
      ),
      body: this.body
    );
  }
}