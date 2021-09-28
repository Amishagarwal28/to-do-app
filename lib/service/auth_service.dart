import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/home_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthClass {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ]);
  final FirebaseAuth auth = FirebaseAuth.instance;
  final storage = new FlutterSecureStorage();

  Future<void> googleSignIn(BuildContext context) async {
    try {
      //open the pop up and in this googleSignInAccount i am goint to store information about google sign in account and ? =non null
      GoogleSignInAccount? _googleSignInAccount = await _googleSignIn.signIn();
      if (_googleSignInAccount != null) {
        //we got the account detail and now we want access token and id token for getting the credentials of google signin
        //it will give id and access token
        GoogleSignInAuthentication _googleSignInAuthentication =
            await _googleSignInAccount.authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
          idToken: _googleSignInAuthentication.idToken,
          accessToken: _googleSignInAuthentication.accessToken,
        );
        //now create instance of firebase and signIn in firebase with google credentials
        try {
          UserCredential _userCredential =
              await auth.signInWithCredential(credential);
          storeTokenAndData(_userCredential);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (ctx) => HomeScreen()),
              (route) => false);
        } catch (e) {
          final snackBar = SnackBar(content: Text(e.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      } else {
        final snackBar = SnackBar(content: Text("Not Able to signIn"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> storeTokenAndData(UserCredential userCredential) async {
    //storage.write=we can store anything
    await storage.write(
        key: "token", value: userCredential.credential!.token.toString());
    //userData and now call storeTokenAndData in googleSignIn to store userCredential
    await storage.write(
        key: "userCredential", value: userCredential.toString());
  }

  Future<String?> getToken() async {
    //it will return the token from the storage
    return await storage.read(key: "token");
  }

  Future<void> logout(BuildContext context) async {
    try {
      //signout from google firebase and delete token from storage
      await _googleSignIn.signOut();
      await auth.signOut();
      await storage.delete(key: "token");
      //now call this method inside homepage
    } catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> verifyPhoneNumber(String phoneNumber,BuildContext context,Function setData) async {
    
      //method where we get phone authentication credential as parameter and phoneAuthCredential can be passed to signInWithCredential
      PhoneVerificationCompleted verificationCompleted=
      (PhoneAuthCredential phoneAuthCredential)async{
        snackBar(context,"Verification Completed");
      };
      //firebase not able to send otp or any failure so it show snackbar
      PhoneVerificationFailed verificationFailed=(FirebaseAuthException exception){
         snackBar(context,exception.toString());
      };
      //after sending otp we wanted to perform other logic too thats why codeSent and 2 parameter
      //verification id= require during logging of firebase ....also id+Resendcode=firebase login
      PhoneCodeSent codeSent=(String verificationId,[forceResendingtoken]){
       snackBar(context,"Verification Code send on the number");
       setData(verificationId);
      };
      //in android automatic sms retrieval like 30s it will automatically verify it
      PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout=(String verificationId){
        snackBar(context,"TimeOut");
      };

     try{ await auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      snackBar(context,e.toString());
    }
  }
  void snackBar(BuildContext context,String text){
    final snackBar=SnackBar(content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  Future<void>signInWithPhoneNumber(String verificationId,String smsCode,BuildContext context)async{
    try{
     //we want the smscode and verification id of the user
     AuthCredential credential=PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
     //passing the credential to firebase
     UserCredential userCredential=await auth.signInWithCredential(credential);
     storeTokenAndData(userCredential);
     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx)=>HomeScreen()), (route) => false);
     snackBar(context, "logged In");
    }
    catch(e)
    {
      snackBar(context, e.toString());
    }
  }
}
