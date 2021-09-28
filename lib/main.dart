import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart' ;
import 'package:to_do_app/screens/add_to_do.dart';
import 'package:to_do_app/screens/home_screen.dart';
import 'package:to_do_app/screens/signin_screen.dart';
import 'package:to_do_app/screens/signup_screen.dart';
import 'package:to_do_app/service/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();//all the widget are binded or not
  await Firebase.initializeApp();//needs to call native code to initialize Firebase also we can use firebase products
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  Widget currentScreen=SignUpScreen();
  final AuthClass auth=new AuthClass();
@override 
void initState(){
  super.initState();
  checkLogin();
}
 Future <void> checkLogin()async{
    String? token =await auth.getToken();
    if(token!=null)
    {
      setState(() {
        currentScreen=HomeScreen();
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
