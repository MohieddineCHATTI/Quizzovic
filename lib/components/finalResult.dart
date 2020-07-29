import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';


class FinalResult extends StatelessWidget {
  int score;
  String userName;
  FinalResult(this.score,this.userName);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Container(
        color: Colors.red,
        child: Column(
          children: <Widget>[
            Text(userName),
            Text(score.toString()),
            IconButton(
              icon: Icon(Icons.refresh),
              iconSize: 50,
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
