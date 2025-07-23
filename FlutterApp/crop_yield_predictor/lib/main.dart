import 'package:flutter/material.dart';
import 'screens/predict_screen.dart'; // This is your single screen

void main() {
  runApp(CropYieldApp());
}

class CropYieldApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crop Yield Predictor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PredictScreen(), // Your single screen
    );
  }
}
