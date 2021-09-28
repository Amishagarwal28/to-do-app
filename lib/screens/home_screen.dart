import 'package:flutter/material.dart';
import 'package:to_do_app/screens/signup_screen.dart';
import 'package:to_do_app/service/auth_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthClass auth = new AuthClass();
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(
          "Today's Schedule",
          style: TextStyle(
              color: Colors.white, fontSize: 34, fontWeight: FontWeight.bold),
        ),
        actions: [
          CircleAvatar(
            backgroundImage: AssetImage("assets/profile.jpeg"),
          ),
          SizedBox(
            width: 25,
          ),
        ],
        bottom: PreferredSize(
          child: Align(alignment: Alignment.centerLeft,
            child: Padding(padding: EdgeInsets.only(left: 25),
              child: Text(
                "Monday 21",
                style: TextStyle(
                    color: Colors.white, fontSize: 33, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          preferredSize: Size.fromHeight(35),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(backgroundColor: Colors.black87,
        items: [
        BottomNavigationBarItem(icon: Icon(Icons.home,color: Colors.white,size: 32,),
        title: Container()),
        
        BottomNavigationBarItem(icon: Icon(Icons.add,color: Colors.white,size: 32,),
        title: Container()),
        BottomNavigationBarItem(icon: Icon(Icons.settings,color: Colors.white,size: 32,),
        title: Container())
      ],),
    );
  }
}
//      IconButton(onPressed:()async{await auth.logout(context);
//     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx)=>SignUpScreen()), (route) => false);
//    }, icon: Icon(Icons.logout))
