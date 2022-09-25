import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:herewego1/pages/home_page.dart';
import 'package:herewego1/pages/signUp_page.dart';
import 'package:herewego1/services/auth.dart';
import 'package:herewego1/services/utils.dart';

import '../services/preferens.dart';
class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);
  static final String id = 'signIn_page';
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isloading = false;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  doSignIn(){
    isloading = true;
  String email = emailController.text.toString().trim();
  String password = passwordController.text.toString().trim();
  if(email.isEmpty ||password.isEmpty)return;

  AuthService.signInUser(context, email, password).then((fireUser) => {
    getFire(fireUser)
  });
  }

  getFire(User fireUser)async{
    isloading = false;
    if(fireUser != null){
      await Prefs.saveUserId(fireUser.uid);
      Navigator.pushReplacementNamed(context, HomePage.id);
    }else{
      Utils.fireToast('Check your email or password');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.all(25),
              child: Column(
                children: [
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        hintText: 'Email'
                    ),
                  ),
                  SizedBox(height: 5,),
                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                        hintText: 'Password'
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    height: 30,
                    width: double.infinity,
                    child: FlatButton(
                      onPressed: (){
                        doSignIn();
                      },
                      color: Colors.red,
                      child: Text('SignIn',style: TextStyle(
                          color: Colors.white
                      ),),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    alignment: Alignment.centerRight,
                    height: 30,
                    width: double.infinity,
                    child: FlatButton(
                      onPressed: (){
                        Navigator.pushReplacementNamed(context, SignUp.id);
                      },
                      child: Text('Don`t have an account?  SIGN IN'),
                    ),
                  )
                ],
              ),
            ),
          ),
          isloading ?
              Center(
                child: CircularProgressIndicator(),
              ):
              SizedBox.shrink()
        ],
      )
    );
  }
}
