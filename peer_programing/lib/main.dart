import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:peer_programing/src/helper/user_model.dart';
import 'package:peer_programing/src/utils/generate_random_gravatar.dart';
import 'routes.dart';
import 'src/theme/theme.dart';

void main() => runApp(MyApp());

void refreshImgPathToUsers(){
  Firestore
    .instance
    .collection(USER_COLLECTION_NAME)
    .getDocuments()
    .then((users) => 
      users
        .documents
        .forEach((user) => 
          user
            .reference
            .updateData({'imgPath': generateRandomGravatarUrl()})
        )
    );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Peer learning',
      theme: AppTheme.lightTheme,
      initialRoute: Routes.initialRoute,
      routes: Routes.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}