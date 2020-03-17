import 'package:flutter/material.dart';
import 'package:peer_programing/src/theme/color/light_color.dart';
import 'package:peer_programing/src/widgets/layouts/main_header.dart';

class MainLayout extends StatelessWidget{
  final routeMap = ['/','/recomended', '/list_selected', '/list_proposals', '/login'];
  final Widget body;

  final String title;
  final Widget headerChild;

  MainLayout({this.body, this.title, this.headerChild});

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
            _bottomIcons(Icons.bookmark ),
            _bottomIcons(Icons.dns),
            _bottomIcons(Icons.account_circle ),
          ],
          onTap: (index) {
            Navigator.pushReplacementNamed(context, this.routeMap[index]);
          },
      ),
      body: SingleChildScrollView(
        child: Container(
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
        )
      )
    );
  }
}