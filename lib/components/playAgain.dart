import 'package:flutter/material.dart';
import 'package:swipable/main.dart';

class Restart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
        icon: Icon(Icons.refresh),
        iconSize: 50,
        onPressed: (){
        },
      ),
    );
  }
}
