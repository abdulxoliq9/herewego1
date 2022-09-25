
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:herewego1/pages/signIn_page.dart';
import 'package:herewego1/services/preferens.dart';

class AuthService{

  static final auth = FirebaseAuth.instance;

  static Future<User> signInUser(BuildContext context,String email,String password) async{
    try {
      auth.signInWithEmailAndPassword(email: email, password: password);
      final User  user = await auth.currentUser!;
      print(user.toString());
      return user;
    }catch(e){
      print(e.toString());
    }return null!;
  }

  static Future<User> signUpUser(BuildContext context,String name,String email,String password)async{
    try{
      var authResult = await auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = authResult.user!;
      print(user.toString());
      return user;
    }catch(e){
      print(e);
    }return null!;
  }

  static void signOutUser(BuildContext context){
    auth.signOut();
    Prefs.removeUserId().then((value){
      Navigator.pushReplacementNamed(context, SignIn.id);
    });
  }

}