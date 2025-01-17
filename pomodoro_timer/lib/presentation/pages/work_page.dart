import 'package:flutter/material.dart';
import 'dart:async';

class WorkPage extends StatefulWidget {
  final int workTime;
  final VoidCallback onComplete;

  WorkPage({required this.workTime, required this.onComplete});

  @override
  _WorkPageState createState() => _WorkPageState();
}

class _WorkPageState extends State<WorkPage> {
  late int _secondsRemaining;
  Timer? _timer;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _secondsRemaining = widget.workTime;
  }

  @override
  void didUpdateWidget(covariant WorkPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.workTime != oldWidget.workTime) {
      _secondsRemaining = widget.workTime;
      _isRunning = false;
      _timer?.cancel();
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        _timer?.cancel();
        widget.onComplete();
      }
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
  }

  void _toggleTimer() {
    setState(() {
      _isRunning = !_isRunning;
    });
    if (_isRunning) {
      _startTimer();
    } else {
      _pauseTimer();
    }
  }

  void _resetTimer() {
    setState(() {
      _secondsRemaining = widget.workTime;
      _isRunning = false;
    });
    _timer?.cancel();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int minutes = _secondsRemaining ~/ 60;
    int seconds = _secondsRemaining % 60;

    return Scaffold(
      body: Container(
        color: Colors.red,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$minutes:${seconds.toString().padLeft(2, '0')}',
                style: TextStyle(fontSize: 48, color: Colors.white),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _toggleTimer,
                child: Text(_isRunning ? 'Pause' : 'Start'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.red,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _resetTimer,
                child: Text('Reset'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

