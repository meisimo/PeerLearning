import 'package:flutter/material.dart';
import 'package:peer_programing/src/theme/color/light_color.dart';
import 'package:peer_programing/src/widgets/layouts/main_header.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainLayout extends StatelessWidget{
  final routeMap = ['/','/recomended', '/list_proposals', '/login'];
  final Widget body;

  final String title;
  final Widget headerChild;
  final bool defaultVerticalScroll;

  MainLayout({this.body, this.title, this.headerChild, this.defaultVerticalScroll=true});

  BottomNavigationBarItem _bottomIcons(IconData icon) {
    return BottomNavigationBarItem(icon: Icon(icon), title: Text(""));
  }

  Widget _body(Widget body){
    return Container(
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
            _bottomIcons(Icons.dns),
            _bottomIcons(Icons.account_circle ),
          ],
          onTap: (index) async {
            SharedPreferences prefs = await SharedPreferences.getInstance();    
            bool logged = (prefs.getBool('logged') == null ? false: prefs.getBool('logged'));
            String ruta = this.routeMap[index];

            print(logged);
            if ( logged && ruta == '/login'){
              ruta = '/user';
            }

            Navigator.pushReplacementNamed(context, ruta);
          },
      ),
      body: defaultVerticalScroll ?  SingleChildScrollView(child: _body(body)) : _body(body)
    );
  }
}