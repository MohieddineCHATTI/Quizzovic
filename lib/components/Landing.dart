//import 'package:flutter/material.dart';
//import 'package:swipable/main.dart';
//
//
//class Landing extends StatefulWidget {
//  @override
//  _LandingState createState() => _LandingState();
//}
//
//class _LandingState extends State<Landing> {
//  Key _formKey = GlobalKey<FormState>();
//  bool proceed = false;
//  String userName;
//
//  @override
//  Widget build(BuildContext context) {
//    return  Scaffold(
//    body: Container(
//      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
//      child: Column(
//        mainAxisAlignment: MainAxisAlignment.center,
//        children: <Widget>[
//          Form(
//            key: _formKey,
//            child: Column(
//              children: <Widget>[
//                TextFormField(onChanged: (val) {
//                  if (val.isNotEmpty){
//                    setState(() {
//                      setState(() {
//                        userName = val;
//                      });
//                      proceed = true;
//
//                    });
//                  }else{
//                    setState(() {
//                      proceed = false;
//                    });
//                  }
//
//                },
//
//                ),
//                !proceed ? Text("enter your name") : FlatButton(onPressed: (){
//                Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp(score, userName)));
//  },
//                  child: Text("start"),
//                )
//              ],
//            ),
//          ),
//        ],
//      ),
//    ),
//  );
//}
//
////onPressed: (){
////setState(() {
////notStarted = false;
////startTimer();
////});