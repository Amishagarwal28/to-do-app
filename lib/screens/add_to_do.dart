import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddToDoScreen extends StatefulWidget {
  const AddToDoScreen({Key? key}) : super(key: key);

  @override
  _AddToDoScreenState createState() => _AddToDoScreenState();
}

class _AddToDoScreenState extends State<AddToDoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xff1d1e26),
          Color(0xff252041),
        ])),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  CupertinoIcons.arrow_left,
                  color: Colors.white,
                  size: 28,
                )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Create",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 33,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 4),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "New Todo",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 33,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    label("Task Title"),
                    SizedBox(
                      height: 12,
                    ),
                    title(),
                    SizedBox(
                      height: 25,
                    ),
                    label("Task Type"),
                    SizedBox(
                      height: 12,
                    ),
                    Row(children: [chipData("Important",0xff2664fa),
                    SizedBox(
                      width: 20,
                    ),
                    chipData("Planned",0xff2bc8d9),
                    ]),
                    SizedBox(
                      height: 25,
                    ),
                    label("Description"),
                    SizedBox(
                      height: 12,
                    ),
                    description(),
                    SizedBox(
                      height: 25,
                    ),
                    label("Category"),
                    SizedBox(
                      height: 12,
                    ),
                    Wrap(runSpacing: 10,
                      children: [chipData("Food",0xffff6d6e),
                    SizedBox(
                      width: 20,
                    ),
                    chipData("Workout",0xfff29732),
                    SizedBox(
                      width: 20,
                    ),
                    chipData("Work",0xff6557ff),
                    SizedBox(
                      width: 20,
                    ),
                    chipData("Design",0xff2664fa),
                    SizedBox(
                      width: 20,
                    ),
                    chipData("Run",0xff2bc8d9),
                    ]),
                    SizedBox(
                      height: 50,
                    ),
                    button(),

                  ]),
            ),
          ],
        )),
      ),
    );
  }
  Widget button()
  {
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(gradient: LinearGradient(colors: [
        Color(0xff8a32f1),
        Color(0xffad32f9),
        ]),
        borderRadius: BorderRadius.circular(20)),
        child: Center(child: Text("Add Todo ",style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600
        )),),
    );
  }
Widget description() {
    return Container(
      height: 120,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Color(
            0xff2a2e3d,
          ),
          borderRadius: BorderRadius.circular(15)),
      child: TextFormField(
        style: TextStyle(
          color: Colors.grey,
          fontSize: 18,
        ),maxLines: null,
        decoration: InputDecoration(
            hintText: "Description",
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
            contentPadding: EdgeInsets.only(left: 20,right: 20),
            ),
      ),
    );
  }

  Widget chipData(String text,int color){
    return Chip(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      label: Text(text,style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w600),),
    labelPadding: EdgeInsets.symmetric(horizontal: 17,vertical: 4),
    backgroundColor: Color(color),);
  }

  Widget title() {
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Color(
            0xff2a2e3d,
          ),
          borderRadius: BorderRadius.circular(15)),
      child: TextFormField(
        style: TextStyle(
          color: Colors.grey,
          fontSize: 18,
        ),
        decoration: InputDecoration(
            hintText: "Task Title",
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
            contentPadding: EdgeInsets.only(left: 20,right: 20),
            ),
      ),
    );
  }

  Widget label(String text) {
    return Text(
      text,
      style: TextStyle(
          color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
    );
  }
}
