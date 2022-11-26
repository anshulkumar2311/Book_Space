import 'package:book_space/HomeScreen.dart';
import 'package:book_space/IT.dart';
import 'package:book_space/practice.dart';
import 'package:book_space/service/Auth_service..dart';
import 'package:flutter/material.dart';
import 'constant.dart';
import 'spalash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth ;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  Widget currentPage = SplashScreen();
  AuthClass authClass = AuthClass();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
  }

  void checkLogin() async{
    String? token =await authClass.getTocken();
    if(token != null){
      setState(() {
        currentPage = HomeScreen();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Space',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      scaffoldBackgroundColor: mBackgroundColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: currentPage,
      // home: Home(),
    );
  }
}
