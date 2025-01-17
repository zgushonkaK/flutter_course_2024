import 'package:flutter/material.dart';
import 'package:pomodoro_timer/presentation/pomodoro_flow.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro Timer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PomodoroFlow(),
    );
  }
}
