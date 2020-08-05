import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:swipable/styles.dart';
import 'dart:io';

class FinalResultNoBestScores extends StatelessWidget {
  int score;
  String userName;
  FinalResultNoBestScores(this.score,this.userName);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration:  BoxDecoration(
              gradient: finalGradient
          ),
            child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(userName, style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: mainTextColor
                    ),),
                    SizedBox(height: 10,),
                    Text("Your final Score is:",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: mainTextColor
                        )),
                    SizedBox(height: 10,),
                    Text(score.toString(), style: TextStyle(
                      color: score<0 ? Colors.red: Colors.green,
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                    ),),
                    SizedBox(height: 20,),
                    IconButton(
                          icon: Icon(Icons.refresh),
                          iconSize: 60,
                          color: Colors.blue,
                          onPressed: (){
                            Phoenix.rebirth(context);
                          },
                        ),]
                    )

                ),
              ),
    );
  }
}