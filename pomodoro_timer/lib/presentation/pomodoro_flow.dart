import 'package:flutter/material.dart';
import 'package:pomodoro_timer/presentation/pages/work_page.dart';
import 'package:pomodoro_timer/presentation/pages/break_page.dart';
import 'package:pomodoro_timer/presentation/pages/settings_page.dart';

class PomodoroFlow extends StatefulWidget {
  @override
  _PomodoroFlowState createState() => _PomodoroFlowState();
}

class _PomodoroFlowState extends State<PomodoroFlow> {
  bool _isWorkTime = true;
  int _workTime = 15 * 60; // 15 minutes
  int _breakTime = 5 * 60; // 5 minutes

  void _toggleTime() {
    setState(() {
      _isWorkTime = !_isWorkTime;
    });
  }

  void _updateTimes(int workTime, int breakTime) {
    setState(() {
      _workTime = workTime;
      _breakTime = breakTime;
    });
  }

  void _resetTimer() {
    setState(() {
      _workTime = 15 * 60; // Reset to default work time
      _breakTime = 5 * 60; // Reset to default break time
      _isWorkTime = true; // Switch to WorkPage
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isWorkTime ? 'Work Time' : 'Break Time'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetTimer,
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsPage(
                    workTime: _workTime,
                    breakTime: _breakTime,
                    onSave: _updateTimes,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: _isWorkTime
          ? WorkPage(workTime: _workTime, onComplete: _toggleTime)
          : BreakPage(breakTime: _breakTime, onComplete: _toggleTime),
    );
  }
}