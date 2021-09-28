import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_do_app/service/auth_service.dart';
import 'home_screen.dart';
import 'signin_screen.dart';
import 'phone_auth_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool circular=false;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  AuthClass authClass=AuthClass();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.black,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Sign Up",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                buttonItem("assets/google.svg", "Continue With Google",()async{
                  print("working properly");
                  await authClass.googleSignIn(context);
                }),
                SizedBox(
                  height: 10,
                ),
                buttonItem("assets/phone.svg", "Continue with Phone",(){
                  Navigator.push(context, MaterialPageRoute(builder: (ctx)=>PhoneAuthScreen()));
                }),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Or",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                SizedBox(
                  height: 15,
                ),
                textItem("Email", _emailController, false),
                SizedBox(
                  height: 15,
                ),
                textItem("Password", _passwordController, true),
                SizedBox(
                  height: 30,
                ),
                colorButton(),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "if you already Have an account?",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    InkWell(onTap: (){
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx)=>SignInScreen()), (route) => false);
                    },
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget colorButton() {
    return InkWell(
      onTap: () async {
        setState(() {
          circular=true;
        });
        try{
          UserCredential userCredential =
            await firebaseAuth.createUserWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text);
        print(userCredential.user!.email);
        setState(() {
          circular=false;
        });
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx)=>HomeScreen()), (route) => false);//and then removes all the routes until the predicate(route) returns true
        }catch(e){
          final snackBar=SnackBar(content: Text(e.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          circular=false;
        }
      },
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width - 90,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(colors: [
              Color(0xfffd746c),
              Color(0xffff9068),
              Color(0xfffd746c),
            ])),
        child: Center(
            child:circular?CircularProgressIndicator(): Text(
          "SignUp",
          style: TextStyle(fontSize: 25, color: Colors.white),
        )),
      ),
    );
  }

  Widget buttonItem(String imagePath, String buttonName,Function tap ) {
    return InkWell(onTap:()=> tap(),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width - 60,
        child: Card(
            elevation: 10,
            color: Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(width: 1, color: Colors.grey)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  imagePath,
                  height: 25,
                  width: 25,
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  buttonName,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                )
              ],
            )),
      ),
    );
  }

  Widget textItem(
      String text, TextEditingController controller, bool obscureText) {
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width - 70,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(color: Colors.white, fontSize: 18),
        decoration: InputDecoration(
            labelText: text,
            labelStyle: TextStyle(color: Colors.white, fontSize: 18),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(width: 1, color: Colors.amber)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(width: 1, color: Colors.grey))),
      ),
    );
  }
}
