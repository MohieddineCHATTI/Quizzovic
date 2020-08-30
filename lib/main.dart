import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipable/data/data.dart';
import 'dart:async';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:swipable/components/Landing.dart';
import 'package:swipable/components/mainBody.dart';
import 'dart:io';

import 'package:swipable/updateQst.dart';


void main() {
  runApp(DataLoading());
}


class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return UpdateQst();
  }
}


class DataLoading extends StatefulWidget {
  @override
  _DataLoadingState createState() => _DataLoadingState();
}

class _DataLoadingState extends State<DataLoading> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        future: Future.delayed(Duration(seconds: 2), () async {return await DatabaseService().getQuestions();}),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if (snapshot.data != null){
              print("data is data :${snapshot.data}");
              return Phoenix(child: MaterialApp(home: MyApp(data: snapshot.data)));
            }else if (snapshot.data == null) {
           return Landing();
          }


            return Landing();
        }

      ),
    );
  }
}


//Phoenix(child: MaterialApp(home: MyApp()))