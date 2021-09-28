import 'dart:async';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:to_do_app/service/auth_service.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({Key? key}) : super(key: key);

  @override
  _PhoneAuthScreenState createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  int start=30;
  bool wait =false;//disable send
  String buttonName="Send";//disable send
  TextEditingController _phoneController=TextEditingController();
  final AuthClass _authClass=AuthClass();
  String verificationIdFinal="";//verify phone number
  String _smsCode="";//verify phone number
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: Text(
          "Sign Up",
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        backgroundColor: Colors.black87,
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 150,
              ),
              textField(),
              SizedBox(height: 30,),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(children: [
                  Expanded(child: Container(height: 1,color: Colors.grey,margin: EdgeInsets.symmetric(horizontal: 12),)),
                  Text("Enter 5 digit OTP",style: TextStyle(color: Colors.white,fontSize: 16),),
                  Expanded(child: Container(height: 1,color: Colors.grey,margin: EdgeInsets.symmetric(horizontal: 12))),
                ],),
              ),
              SizedBox(height: 30,),
              otpField(),
              SizedBox(height: 40,),
              RichText(text: TextSpan(children: [
                TextSpan(
                  text: "Send OTP again in ",
                  style: TextStyle(color: Colors.yellowAccent,fontSize: 16),
                ),
                TextSpan(
                  text: "00:$start",
                  style: TextStyle(color: Colors.pinkAccent,fontSize: 16),
                ),
                TextSpan(
                  text: " sec",
                  style: TextStyle(color: Colors.yellowAccent,fontSize: 16),
                )
              ]),),
              SizedBox(height: 150,),
              InkWell(onTap: (){
                _authClass.signInWithPhoneNumber(verificationIdFinal, _smsCode, context);
              },
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width-60,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                  color: Color(0xffff9601)),
                  child: Center(child: Text("Let's Go",style: TextStyle(fontSize: 18,color: Color(0xfffbe2ae),fontWeight: FontWeight.w700),),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void startTimer(){
    const onesec=Duration(seconds: 1);
    Timer  _timer=Timer.periodic(onesec, (_timer) { 
      if(start==0)
      {
        setState(() {
          _timer.cancel();
          start=30;
          wait=false;//send disable
        });
      }else{
        setState(() {
          start--;
        });
      }
    });
  }
Widget otpField(){
  return OTPTextField(
  length: 6,
  width: MediaQuery.of(context).size.width-20,
  fieldWidth: 46,
  otpFieldStyle: OtpFieldStyle(
    backgroundColor: Color(0xff1d1d1d),
    borderColor: Colors.white,
  ),
  style: TextStyle(
    fontSize: 18,
    color: Colors.white
  ),
  textFieldAlignment: MainAxisAlignment.spaceAround,
  fieldStyle: FieldStyle.underline,
  onCompleted: (pin) {
    setState(() {
    _smsCode=pin;
    });
  },
);
}

  Widget textField(){
    return Container(
                height: 60,
                width: MediaQuery.of(context).size.width - 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color(0xff1d1d1d),
                ),
                child: TextFormField(controller: _phoneController,
                style: TextStyle(color: Colors.white),
                
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 19, horizontal: 8),
                    border: InputBorder.none,
                    hintText: "Enter Phone number",
                    hintStyle: TextStyle(color: Colors.white54, fontSize: 17),
                    prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 8),
                        child: Text(
                          "(+91)",
                          style: TextStyle(color: Colors.white, fontSize: 18,),
                        )),
                    suffixIcon: InkWell(onTap:wait?null: ()async{//send disable
                      setState(() { 
                        start=30;
                        wait=true;
                        buttonName="Resend";
                      });
                      await _authClass.verifyPhoneNumber("+91 ${_phoneController.text}", context,setData);
                    },
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 15),
                          child: Text(
                            buttonName,//send disable
                    //after clicking on the send button we are going to disable the send button          
                            style: TextStyle(
                                color:wait?Colors.grey: Colors.white,//send disable
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
              );
  }
  void setData(verificationId)
  {
    setState(() {
      //take verification id from auth service
      verificationIdFinal=verificationId;//this verificatuion id will be required when i will click on lets go

    });
    startTimer();
  }
}
