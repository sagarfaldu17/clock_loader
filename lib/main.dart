
import 'package:flutter/material.dart';
import 'package:sf_biomatric_auth/biomatric_auth/biomatric_auth.dart';

void main() {
  // debugRepaintRainbowEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: Center(
          child: Container(
            alignment: Alignment.center,
            color: Color(0xFFff5558),
            child: BioMatricAuth(),
          ),
        ),
      ),
    );
  }
}
