import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:herewego1/pages/home_page.dart';
import 'package:herewego1/pages/signIn_page.dart';
import 'package:herewego1/services/auth.dart';
import 'package:herewego1/services/preferens.dart';
import 'package:herewego1/services/utils.dart';
class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  static final String id = 'signUp_page';
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isloading = false;
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  doSignUp(){
    var name = nameController.text.toString().trim();
    var email = emailController.text.toString().trim();
    var password = passwordController.text.toString().trim();
    setState(() {
      isloading = true;
    });
    AuthService.signUpUser(context, name, email, password).then((fireUser) => {
      getFire(fireUser)
    });

  }

  getFire(User fireUser)async{
    setState(() {
      isloading = false;
    });
    if(fireUser != null){
      await Prefs.saveUserId(fireUser.uid);
      Navigator.pushReplacementNamed(context, HomePage.id);
    }else{
      Utils.fireToast('Chrck your informations');
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                        hintText: 'Name'
                    ),
                  ),
                  SizedBox(height: 5,),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        hintText: 'Email'
                    ),
                  ),
                  SizedBox(height: 5,),
                  TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                        hintText: 'Password'
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    height: 40,
                    width: double.infinity,
                    child: FlatButton(
                      onPressed: (){
                        doSignUp();
                      },
                      color: Colors.red,
                      child: Text('Sign Up',style: TextStyle(
                          color: Colors.white
                      ),),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    alignment: Alignment.centerRight,
                    height: 40,
                    width: double.infinity,
                    child: FlatButton(
                      onPressed: (){
                        Navigator.pushReplacementNamed(context, SignIn.id);
                      },
                      child: Text('Already have an account?  SIGN IN'),
                    ),
                  )
                ],
              ),
            ),
          ),
          isloading?
          Center(
            child: CircularProgressIndicator()
            ,
          ):
              SizedBox.shrink()
        ],
      )
    );
  }
}
