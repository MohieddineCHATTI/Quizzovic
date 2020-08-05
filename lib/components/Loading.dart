import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:io';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  bool error = false;
  @override
  Widget build(BuildContext context) {

    Timer(Duration(seconds: 10), (){
      if (mounted){
        setState(() {
          error =true;
        });
      }

    });

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          actions: <Widget>[FlatButton.icon(icon: Icon(Icons.exit_to_app,size:30,color: Colors.black),label: Text("Exit"),onPressed: () {exit(0);} )],
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
              !error ? Text("Loading ...",
                style:TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),): Text("Unknown Problem \nPress Exit to Quit the Game", style: TextStyle(
                fontSize: 20,
                color: Colors.red,
                fontWeight: FontWeight.bold
              ),textAlign: TextAlign.center,)
            ],
          )
        ),
      ),
    );
  }
}
