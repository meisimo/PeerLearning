import 'package:flutter/material.dart';
import 'package:peer_programing/src/widgets/layouts/main_layout.dart';

class UserPage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MainLayout(
      body:Text("Users")
    );
  }
}