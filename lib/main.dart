import 'package:flutter/material.dart';
import 'src/screens/example.dart'; // Import the ExamplePage

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ExamplePage(), // Set ExamplePage as the home screen
    );
  }
}
