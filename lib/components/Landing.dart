import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:io';


class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  bool networkConnection = true;
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 10), (){
      if(mounted){
        setState(() {
          networkConnection =false;
        });
      }

    });

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          actions: <Widget>[FlatButton.icon(icon: Icon(Icons.exit_to_app,size:30,color: Colors.black),label: Text("Exit"),onPressed: () {exit(0);} ) ],
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(image: AssetImage("assets/images/logo.png"),
              width: 90,
              height: 90,),

              SizedBox(height: 70,),
              SpinKitHourGlass(
                size: 20,
                color: Colors.black,
              ),
              SizedBox(height: 40,),
              networkConnection? Text("Loading..",
                style:TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),): Text("Network Problem \nCheck Your Network and Try Again", style: TextStyle(
                fontSize: 20,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),textAlign: TextAlign.center,)
            ],
          )
        ),
      ),
    );
  }
}
