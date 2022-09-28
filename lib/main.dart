import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:herewego1/pages/detail_page.dart';
import 'package:herewego1/pages/home_page.dart';
import 'package:herewego1/pages/signIn_page.dart';
import 'package:herewego1/pages/signUp_page.dart';
import 'package:herewego1/services/preferens.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) => print('fireBase'));
  runApp(const MyApp());
}

Widget startPage(){
  return StreamBuilder<User?>(
    stream: FirebaseAuth.instance.authStateChanges(),
    builder: (BuildContext context, snapshot){
      if(snapshot.hasData){
        Prefs.saveUserId(snapshot.data!.uid);
        return HomePage();
      }else{
    Prefs.removeUserId();
    return const SignIn();
      }
  }
  );
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: startPage(),
      routes: {
        HomePage.id: (context) => HomePage(),
        SignIn.id: (context) => SignIn(),
        SignUp.id: (context) => SignUp(),
        DetailPage.id: (context) => DetailPage()
      },
    );
  }
}
