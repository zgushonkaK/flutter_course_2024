import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  final int workTime;
  final int breakTime;
  final Function(int, int) onSave;

  SettingsPage({
    required this.workTime,
    required this.breakTime,
    required this.onSave,
  });

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late TextEditingController _workTimeController;
  late TextEditingController _breakTimeController;

  @override
  void initState() {
    super.initState();
    _workTimeController = TextEditingController(text: (widget.workTime ~/ 60).toString());
    _breakTimeController = TextEditingController(text: (widget.breakTime ~/ 60).toString());
  }

  void _saveSettings() {
    int workTime = (int.tryParse(_workTimeController.text) ?? 15) * 60;
    int breakTime = (int.tryParse(_breakTimeController.text) ?? 5) * 60;
    widget.onSave(workTime, breakTime);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Work Time (minutes)'),
              keyboardType: TextInputType.number,
              controller: _workTimeController,
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(labelText: 'Break Time (minutes)'),
              keyboardType: TextInputType.number,
              controller: _breakTimeController,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveSettings,
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

