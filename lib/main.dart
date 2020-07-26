import 'package:flutter/material.dart';
import 'package:swipable/data/data.dart';
import 'dart:async';
import 'package:swipable/components/finalResult.dart';
import 'package:audioplayers/audio_cache.dart';
import 'styles.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: App(),
    );
  }
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  bool notStarted = true;
  List data = database;
  int score = 0 ;
  int qstNumber = 0;
  int timeNow =15;
  bool stopCounting = false;
  Color scoreColor =  primary;
  Color correctAns = Color.fromRGBO(0, 250, 0, 1);
  Color wrongAns = Color.fromRGBO(255, 0, 0, 1);

  final player = AudioCache();
  @override
  Widget build(BuildContext context) {
    player.loadAll(["correct.mp3", "wrong.mp3"]);
    startTimer (){
      const period = Duration(seconds: 1);
      Timer.periodic(period,  (timer) {
        if (timeNow > 0 && !stopCounting){
          setState(() {
            timeNow = timeNow-1;
            print(timeNow);
          });
        }else if (stopCounting){
          timer.cancel();
        }else if ((timeNow <= 0)){
          setState(() {
            if(qstNumber <data.length-1){
              setState(() {
                qstNumber++;
              });
          timeNow = 15;
            }else{
              print("last Q");
              Navigator.push(context, MaterialPageRoute(builder: (context) => FinalResult()));
              stopCounting = true;
              timer.cancel();
            }

          });
        }
      });
    }
    Widget start (){
        return Container(
          color: Colors.green,
          child: FlatButton(
            child: Text("start"),
              onPressed: (){
              setState(() {
                notStarted = false;
                startTimer();
              });
    },
        ) ,
        );
    }



    return notStarted ? start(): MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (context)=>Container(
            decoration: BoxDecoration(
              gradient: (LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color.fromRGBO(50,50 , 7, 1), Color.fromRGBO(0, 60, 61, 1)]
              ))
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(0), topRight: Radius.circular(0), bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                        color: scoreColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0 ,10),
                        child: Center(
                          child: Text("Score  :  ${score.toString()}",style: TextStyle(
                            fontSize: 20,
                          ),),
                        ),
                      ),
                    ),

                  SizedBox(height: 30,),
                  Expanded(
                    flex: 2,
                    child: Center(child: Container(constraints: BoxConstraints.expand(),
//                        decoration: BoxDecoration(
//                          borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30), bottomLeft: Radius.circular(0), bottomRight: Radius.circular(0)),
//                        color:Color.fromRGBO(255, 132, 0, 0.1),),
                      child: Center(child: Text(data[qstNumber][0],
                    style: TextStyle(
                      color: qstTextColor,
                      fontSize: 28
                    ),),
                    ))),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                         for (int i =1; i< data[qstNumber].length; i++)
                           MaterialButton(
                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                             color: primary,
                               minWidth: MediaQuery.of(context).size.width*2/3,
                               onPressed: (){
                              if (data[qstNumber][i] == data[qstNumber][1]) {
                              print("correct");
                              player.play("correct.mp3");
                              setState(() {
                              stopCounting = true;
                              score = score+timeNow;
                              scoreColor = correctAns;
                              });
                              setState(() {
                              timeNow = 15;
                              stopCounting = false;
                              });
//                           Scaffold.of(context).showSnackBar(SnackBar(
//                             content: Text("correct"),
//                           ));
                              if(qstNumber <data.length-1){
                                setState(() {
                                qstNumber++;
                                });
//                              startTimer();
                              }else{
                                print("last Q");
                                Navigator.push(context, MaterialPageRoute(builder: (context) => FinalResult()));

                              }

                              }else{
                              print("wrong");
                              player.play("wrong.mp3");
                              setState(() {
                              stopCounting = true;
                              score = score-timeNow;
                              scoreColor = wrongAns;
                              });
                              setState(() {
                              timeNow = 15;
                              stopCounting = false;
                              });
                              if(qstNumber <data.length-1) {
                                setState(() {
                                  qstNumber++;
                                });
                              }else{
                                print("last Q");
                                Navigator.push(context, MaterialPageRoute(builder: (context) => FinalResult()));

                              }
//                           Scaffold.of(context).showSnackBar(SnackBar(
//                             content: Text("Wrong"),
//                           ));
                              }}
                              ,
                               child: Text(data[qstNumber][i]),
                           ),


                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: primary,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(timeNow.toString()),
                    ),
                  )


                ],
              ),
            ),
          ),
        ),
      )
    );

  }
}

