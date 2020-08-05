import 'package:flutter/material.dart';
import 'package:swipable/data/data.dart';
import 'dart:async';
import 'package:swipable/components/finalResult.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:swipable/styles.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';



class MyApp extends StatefulWidget {
  List data;
  MyApp({this.data});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool notStarted = true;
  List data = importedDatabase;
  int score = 0 ;
  int qstNumber = 0;
  int timeNow =10;
  bool stopCounting = false;
  Color scoreColor =  primary;
  Color correctAns = Color.fromRGBO(0, 250, 0, 1);
  Color wrongAns = Color.fromRGBO(255, 0, 0, 1);
  Key _formKey = GlobalKey<FormState>();
  bool proceed = false;
  String userName = " user" ;
  bool buttonDisabled = false;
  List<Color> btnColorIdle = [btnIdle, btnIdle, btnIdle, btnIdle ];
  List<Color> btnColor = [btnIdle, btnIdle, btnIdle, btnIdle];
  List qstOrder = [1,2,3,4];


  final player = AudioCache();
  @override
  Widget build(BuildContext context) {
    player.loadAll(["correct.mp3", "wrong.mp3"]);
    startTimer () {
        qstOrder.shuffle();
      const period = Duration(seconds: 1);
      Timer.periodic(period,  (timer) async {
        if(mounted){
          if (timeNow > 0 && !stopCounting){
            setState(() {
              btnColor = btnColorIdle;
            });
            setState(() {
              timeNow = timeNow-1;
              print(timeNow);
            });
          }else if (stopCounting){
            timer.cancel();
          }else if ((timeNow <= 0)){
            player.play("wrong.mp3");
            timer.cancel();
            await  Future.delayed(Duration(seconds: 2), (){
              if(qstNumber <data.length-1){
                setState(() {
                  qstNumber++;
                  timeNow = 10;
                  btnColor = btnColorIdle;
                  startTimer();

                });

              }else{
                print("last Q");
                Navigator.push(context, MaterialPageRoute(builder: (context) => Final(username: userName, score: score)));
                stopCounting = true;

                timer.cancel();
              }
            });


          }
        }

      });
    }
    Widget start (){

      return Scaffold(
        body: InkWell(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            decoration: BoxDecoration(
              gradient: landingGradient,

            ),
            padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(maxLength: 10,
                        textAlign: TextAlign.center,

                        onChanged: (val) {
                          if (val.isNotEmpty){
                            setState(() {
                              setState(() {
                                userName = val;
                              });
                              proceed = true;

                            });
                          }else{
                            setState(() {
                              proceed = false;
                            });
                          }

                        },
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold
                        ),
                        decoration: InputDecoration(
                          fillColor: Color.fromRGBO(245, 243, 244, 1),
                          filled: true,
                          hintText: "Enter Your Name Here..",
                        ),

                      ),
                      SizedBox(height: 40,),
                      !proceed ? Text("") : FlatButton(
                        child: Text("START", style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),),
                        onPressed: (){
                          setState(() {
                            notStarted = false;
                            stopCounting = false;
                            startTimer();
                          });
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    resetBtnColor () {
      for (int i = 1; i < data[qstNumber].length; i++) {
        setState(() {
          btnColor[i - 1] = btnIdle;
        });
      }
    }

    return notStarted ? start(): MaterialApp(
        home: Scaffold(
          body:Container(
              decoration: BoxDecoration(
                gradient: mainGradient,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 2,color: mainBorderColor),),
                      gradient: appBarGradient,

//                        borderRadius: BorderRadius.only(topLeft: Radius.circular(0), topRight: Radius.circular(0), bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
//                      color: Colors.grey[300],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 30, 0 ,10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children:<Widget>[
                            IconButton(
                              icon: Icon(Icons.refresh,
                              color: mainTextColor,),
                              onPressed: (){
                                setState(() {
                                  stopCounting = true;
                                });
                                Phoenix.rebirth(context);
//                                restart();

                              },
                            ),
                            Text(score.toString(),style: TextStyle(
                              fontSize: 20,
                              color: mainTextColor
                            ),),
                            Text(userName,style: TextStyle(
                              fontSize: 22,
                              color: mainTextColor
                            ),)]
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
                        child: Center(child: Text(data[qstNumber]["qst"],
                          style: TextStyle(
                              color: mainTextColor,
                              fontSize: 28
                          ),),
                        ))),
                  ),
                  Divider(
                    height:1,
                    thickness: 1,
                    color: mainBorderColor,
                    indent: 40,
                    endIndent: 40,
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        for (int i =1; i< data[qstNumber].length; i++)
                          MaterialButton(
                            color: btnColor[i-1],
                            shape: RoundedRectangleBorder(side: BorderSide(
                              color: mainBorderColor,
                            ),borderRadius: BorderRadius.circular(30)),
                            elevation: 1,
                            minWidth: MediaQuery.of(context).size.width*2/3,
                            padding: EdgeInsets.fromLTRB(2, 10 , 2, 10),

                            onPressed: buttonDisabled? (){} : () async {
                              buttonDisabled = true;
                              if (data[qstNumber]["ans${qstOrder[i -1]}"] == data[qstNumber]["ans1"]) {
                                print("correct");
                                player.play("correct.mp3");

                                setState(() {
                                  btnColor[i-1] = btnCorrect;
                                  stopCounting = true;
                                  score = score+timeNow;
                                  scoreColor = correctAns;
                                });
                                await Future.delayed(Duration(seconds: 2), (){
                                  setState(() {
                                    timeNow = 10;
                                    stopCounting = false;
                                    resetBtnColor();
                                  });
                                  if(qstNumber <data.length-1){
                                    setState(() {
                                      buttonDisabled = false;
                                      qstNumber++;
                                      startTimer();
                                    });
                                  }else{
                                    print("last Q");
                                    setState(() {
                                      stopCounting = true;
                                    });
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => Final(username: userName, score: score)));

                                  }
                                });





                              }else{
                                print("wrong");
                                player.play("wrong.mp3");
                                setState(() {
                                  btnColor[i-1] = btnWrong;
                                  stopCounting = true;
                                  score = score-(timeNow/2).round();
                                  scoreColor = wrongAns;
                                });
                                for (int i = 1; i< data[qstNumber].length; i++){
                                  if (data[qstNumber]["ans${qstOrder[i -1]}"] == data[qstNumber]["ans1"]){
                                    setState(() {
                                      btnColor[i-1] = btnCorrect;
                                    });}}
                                await Future.delayed(Duration(seconds: 2) ,(){
                                  setState(() {
                                    timeNow = 10;
                                    stopCounting = false;
                                    resetBtnColor();
                                  });
                                  if(qstNumber <data.length-1) {
                                    setState(() {
                                      buttonDisabled = false;
                                      qstNumber++;
                                      startTimer();
                                    });
                                  }else{
                                    print("last Q");
                                    setState(() {
                                      stopCounting = true;
                                    });

                                    Navigator.push(context, MaterialPageRoute(builder: (context) => Final(username: userName, score: score)));

                                  }
                                });


//
                              }}
                            ,
                            child: Text(data[qstNumber]["ans${qstOrder[i -1]}"], style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.black
                            ),),
                          ),


                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: mainGradient,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(timeNow.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20
                        ),),
                    ),
                  )


                ],
              ),
            ),
          ),

    );

  }
}
