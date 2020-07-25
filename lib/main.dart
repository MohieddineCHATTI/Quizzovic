import 'package:flutter/material.dart';
import 'package:swipable/data/data.dart';
import 'dart:async';
import 'package:swipable/components/finalResult.dart';

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
  int timeNow =10;
  bool stopCounting = false;
  Color ansColor =  Colors.black;
  @override
  Widget build(BuildContext context) {
    Timer _timer;
    startTimer (){
      const period = Duration(seconds: 1);
      _timer = Timer.periodic(period,  (timer) {
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
          timeNow = 10;
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
        appBar: AppBar(),
        body: Builder(
          builder: (context)=>Container(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Center(child: Container(child: Text(data[qstNumber][0]))),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                       for (int i =1; i< data[qstNumber].length; i++)
                         RaisedButton(
                             onPressed: (){
                            if (data[qstNumber][i] == data[qstNumber][1]) {
                            print("correct");
                            setState(() {
                            stopCounting = true;
                            score = score+timeNow;
                            ansColor = Colors.green;
                            });
                            setState(() {
                            timeNow = 10;
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
                            setState(() {
                            stopCounting = true;
                            score = score-timeNow;
                            ansColor = Colors.red;
                            });
                            setState(() {
                            timeNow = 10;
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
                      Text(timeNow.toString())

                    ],
                  ),
                ),
                Text(score.toString(),style: TextStyle(
                  color: ansColor,
                  fontSize: 40,
                ),)
              ],
            ),
          ),
        ),
      )
    );

  }
}

