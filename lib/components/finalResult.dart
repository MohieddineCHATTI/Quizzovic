import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:swipable/styles.dart';


class FinalResult extends StatelessWidget {
  int score;
  String userName;
  FinalResult(this.score,this.userName);
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: finalGradient
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(userName, style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: mainTextColor
            ),),
            SizedBox(height: 20,),
            Text("Your final Score is:",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: mainTextColor
                )),
            SizedBox(height: 20,),
            Text(score.toString(), style: TextStyle(
              color: score<0 ? Colors.red: Colors.green,
              fontSize: 60,
              fontWeight: FontWeight.w700,
            ),),
            SizedBox(height: 70,),
            IconButton(
              icon: Icon(Icons.refresh),
              iconSize: 90,
              color: Colors.blue,
              onPressed: (){
                Phoenix.rebirth(context);
              },
            ),

          ],
        ),
      ),
    );
  }
}
