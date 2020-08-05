import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

List importedDatabase;

class DatabaseService {

  final CollectionReference questionDatabase = Firestore.instance.collection("questions");
  final CollectionReference scoreDatabase = Firestore.instance.collection("scores");

Future checkConnectivity () async{
  try{
    final result = await InternetAddress.lookup("google.com");
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty){
      print("connected");
      return true;
    }
  }on SocketException catch (e){
    print("not connected");
    return false;
  }
}
Future getQstCount ()async{
    QuerySnapshot snap = await Firestore.instance.collection("questions").getDocuments();
    int qstNumbers = snap.documents.toList().length;
    return (qstNumbers);
  }

//  Future updateQst(List data) async {
//    int qstCount = await getQstCount();
//    print("this is quest count: ${qstCount.toString()}");
//    for (int i = qstCount; (i < database.length + qstCount); i++) {
//      await questionDatabase.document(i.toString()).setData({
//        "qst": data[i-qstCount][0],
//        "ans1": data[i-qstCount][1],
//        "ans2": data[i-qstCount][2],
//        "ans3": data[i-qstCount][3],
//        "ans4": data[i-qstCount][4]
//      });
//    }
//  }

Future getQuestions ()async{
        bool connectivity = await DatabaseService().checkConnectivity();
        if (connectivity){
          QuerySnapshot snapshot = await Firestore.instance.collection("questions").getDocuments();
          var list = snapshot.documents.map((e) => (e.data)).toList();
          importedDatabase = list;
          return importedDatabase;
        }else{
          return null;
        }

}

Future updateScores(String name, int score) async {
    String  id = DateTime.now().millisecondsSinceEpoch.toString();

      await scoreDatabase.document(id).setData({
        "name": name,
        "score": score,
        "id": id
      });
    }

Future getScores (String name , int score)async{
  bool connectivity = await DatabaseService().checkConnectivity();
  if (connectivity){
    QuerySnapshot snapshot = await Firestore.instance.collection("scores").orderBy("score", descending: true).getDocuments();
    var list = snapshot.documents.map((e) => (e.data)).toList();
    print (list);
    if (score > list[list.length-1]["score"]){
      await DatabaseService().updateScores(name, score);
      if(snapshot.documents.length > 10){
        Firestore.instance.collection("scores").document(list[list.length-1]["id"]).delete();
      }
      snapshot = await Firestore.instance.collection("scores").orderBy("score", descending: true).getDocuments();
      list = snapshot.documents.map((e) => (e.data)).toList();
      print (list);

    }
    return list;
  } else{
    return null;
  }


    }
  }




