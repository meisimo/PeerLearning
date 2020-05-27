import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:peer_programing/src/helper/user_model.dart';
import 'package:peer_programing/src/helper/mentoring_model.dart';
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

String generateRandomPhone(){
  Random rand = new Random();
  String phone = "3";
  return phone += rand.nextInt(999999999).toString();
}

void setPhoneToUsers(){
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
            .updateData({'telefono': generateRandomPhone()})
        )
    );
}

void refreshMentoring(){
  Firestore
    .instance
    .collection( MENTORING_COLLECTION_NAME )
    .getDocuments()
    .then((mentorings) => 
      mentorings
        .documents
        .forEach((mentoring){
          bool successfull = (mentoring.data['closed'] != null && mentoring.data['closed'] && mentoring.data['selectedBy'] != null);
          mentoring
            .reference
            .updateData({'successfull': successfull});
        }
        )
    );
}

void checkMentoring(){
  Firestore
    .instance
    .collection( MENTORING_COLLECTION_NAME )
    .getDocuments()
    .then((mentorings) => 
      mentorings
        .documents
        .forEach((mentoring){
          print(mentoring.data['successfull']);
        }
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