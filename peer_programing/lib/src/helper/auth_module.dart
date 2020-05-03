import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BasicAuth {
  Future<String> signIn(String email, String pasword);
  Future<String> signUp(String nombre, String email, String pasword);
  Future<FirebaseUser> getCurrentUser();
  Future<void> signOut();
}

class Auth implements BasicAuth {
  final FirebaseAuth _fbAuth = FirebaseAuth.instance;

  @override
  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _fbAuth.currentUser();
    return user;
  }

  @override
  Future<String> signIn(String email, String password) async {
    AuthResult result = await _fbAuth.signInWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    return user.uid;
  }

  @override
  Future<void> signOut() {
    return _fbAuth.signOut();
  }

  @override
  Future<String> signUp(String name, String email, String password) async {
    AuthResult result = await _fbAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    Map<String, dynamic> userData = {
      'authId': user.uid,
      'name': name,
      'email': email,
      'categories': null,
    };
    await Firestore.instance.collection('user').add(userData);
    return user.uid;
  }
}
