import 'package:flutter/material.dart';

Color primary = Color.fromRGBO(0, 132, 194, 1);
Color bgColor =  Colors.black;
Color mainTextColor = Colors.black;
Gradient mainGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color.fromRGBO(0, 69, 102, 1), Color.fromRGBO(100, 180, 217, 1)]
);
Gradient appBarGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color.fromRGBO(0, 69, 102, 1), Color.fromRGBO(0, 132, 194, 1)]
);
Gradient landingGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color.fromRGBO(0, 69, 102, 1), Color.fromRGBO(0, 132, 194, 1)]
);
Gradient finalGradient = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topCenter,
    colors: [Color.fromRGBO(0, 191, 188, 1), Color.fromRGBO(1, 69, 68, 1)]
);

Color btnIdle = Color.fromRGBO(0, 132, 194, 1);
Color btnCorrect = Color.fromRGBO(0, 255, 0, 1);
Color btnWrong = Color.fromRGBO(255, 0, 0, 1);

Color mainBorderColor = Color.fromRGBO(0, 255, 251, 1);
