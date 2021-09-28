import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart' ;
import 'package:to_do_app/screens/signup_screen.dart';
import 'package:to_do_app/service/auth_service.dart';
import 'home_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final AuthClass authClass=AuthClass();
  bool circular=false;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sign In",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              buttonItem("assets/google.svg","Continue With Google",()async{await 
              authClass.googleSignIn(context);}),
              SizedBox(
                height: 10,
              ),
              buttonItem("assets/phone.svg","Continue with Phone",(){}),
              SizedBox(height: 15,),
              Text("Or",style: TextStyle(fontSize: 20,color: Colors.white),),
              SizedBox(height: 15,),
              textItem("Email",_emailController,false),
              SizedBox(height: 15,),
              textItem("Password",_passwordController,true),
              SizedBox(height: 30,),
              colorButton(),
              SizedBox(height: 20,),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Text("if you don't Have an account?",
                   style: TextStyle(fontSize: 16,color: Colors.white),),
                   InkWell(onTap:()=> Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx)=>SignUpScreen()), (route) => false),
                     child: Text("SignUp",style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.w900),)),
                ],
              ),
              SizedBox(height: 10,),
              Text("ForgotPassword",style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.w900),),
            ],
          ),
        ),
      ),
    );
  }
  Widget colorButton(){
    return InkWell(onTap: ()async{
      setState(() {
        circular=true;
      });
      try{
         UserCredential userCredential=await firebaseAuth.signInWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
         
      print(userCredential.user!.email);
        setState(() {
          circular=false;
        });
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx)=>HomeScreen()), (route) => false);//and then removes all the routes until the predicate(route) returns true
        }catch(e){
          final snackBar=SnackBar(content: Text(e.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          setState(() {
          circular=false;
        });
        }
    },
      child: Container(height: 60,
        width: MediaQuery.of(context).size.width - 90,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(colors: [
          Color(0xfffd746c),
          Color(0xffff9068),
          Color(0xfffd746c),
        ])),
        child: Center(child:circular?CircularProgressIndicator(): Text("SignIn",style: TextStyle(fontSize: 25,color: Colors.white),)),),
    );
  }
  Widget buttonItem(String imagePath,String buttonName,Function tap) {
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
