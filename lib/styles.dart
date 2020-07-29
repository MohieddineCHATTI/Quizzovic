import 'package:flutter/material.dart';

Color primary = Color.fromRGBO(54, 168, 164, 1);
Color bgColor =  Color.fromRGBO(56, 55, 35,1);
Color mainTextColor = Color.fromRGBO(247, 236, 183, 1);
Gradient mainGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color.fromRGBO(250,250 , 7, 1), Color.fromRGBO(150, 60, 61, 1)]
);
Gradient landingGradient = LinearGradient(
    begin: Alignment.center,
    end: Alignment.bottomRight,
    colors: [Color.fromRGBO(0,250 , 250, 1), Color.fromRGBO(0, 200, 61, 1)]
);
Gradient finalGradient = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topCenter,
    colors: [Color.fromRGBO(0,0 , 0, 1), Color.fromRGBO(122, 39, 67, 1)]
);