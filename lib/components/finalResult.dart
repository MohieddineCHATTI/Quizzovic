import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:swipable/data/data.dart';
import 'package:swipable/main.dart';
import 'package:swipable/styles.dart';
import 'package:swipable/components/Loading.dart';
import 'dart:io';
import 'finalResultNoBestScores.dart';


class Final extends StatelessWidget {
  int score;
  String username;
  Final({this.username, this.score});
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to exit an App'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              FlatButton(
                onPressed: () => exit(0),
                /*Navigator.of(context).pop(true)*/
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
            false;
      },
      child: MaterialApp(
        home: FutureBuilder(
            future: Future.delayed(Duration(seconds: 2), () async {return await DatabaseService().getScores(username,score);}),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              if (snapshot.connectionState == ConnectionState.done){
                if (snapshot.data != null){
                  print("done");
                  print(snapshot.data);
                  return FinalResult(score, username, snapshot.data);
                }else {
                  return FinalResultNoBestScores(score, username);
                }
              }else {
                return Loading();
              }




            }

        ),
      ),
    );
  }
}





class FinalResult extends StatelessWidget {
  int score;
  String userName;
  List bestScores;
  FinalResult(this.score,this.userName, this.bestScores);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
                decoration:  BoxDecoration(
                gradient: finalGradient
              ),
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height*2/5,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.refresh),
                          iconSize: 60,
                          color: Colors.blue,
                          onPressed: (){
                            Phoenix.rebirth(context);
                          },
                        ),

                      ],
                    )



                  ],
                ),
              ),
              Expanded(
                child: Container(

                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Text("Best Results", style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold
                        ),),
                      ),
                      Flexible(
                        child: ListView.builder(
                          itemCount: bestScores.length,
                          itemBuilder: (context, index){

                            return Padding(
                              padding: const EdgeInsets.fromLTRB(40, 5, 40, 5),
                              child: Card(
                                color: Colors.white70,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.teal, width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListTile(
                                  leading: Text("${(index+1).toString()}/", style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                  ),),
                                  title: Text(bestScores[index]["score"].toString(), style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500
                                  ),),
                                  subtitle: Text(bestScores[index]["name"]),
                                ),
                              ),
                            );}
                        ),
                      ),
                    ],
                  ),
                ),
              )],
          ),
        ),
      ),
    );
  }
}
