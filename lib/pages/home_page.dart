import 'package:flutter/material.dart';
import 'package:herewego1/pages/signIn_page.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static final String id = 'home_page';
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        title: Text('Home'),
      ),
      body: Center(
        child: FlatButton(
          onPressed: (){
            Navigator.pushReplacementNamed(context, SignIn.id);
          },
          color: Colors.redAccent,
          child: Text('LogOut',style: TextStyle(
            color: Colors.white
          ),),
        ),
      ),
    );
  }
}

