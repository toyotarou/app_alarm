import 'package:flutter/material.dart';

import 'components/daily_alarm_list_alert.dart';
import 'components/parts/alarm_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                AlarmDialog(
                  context: context,
                  widget: const DailyAlarmListAlert(),
                );
              },
              child: const Text('aaaaa'),
            ),
          ],
        ),
      ),
    );
  }
}
