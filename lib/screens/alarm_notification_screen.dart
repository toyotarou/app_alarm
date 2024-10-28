import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AlarmNotificationScreen extends StatefulWidget {
  AlarmNotificationScreen({super.key, required this.alarmSettings});

  AlarmSettings alarmSettings;

  @override
  State<AlarmNotificationScreen> createState() =>
      _AlarmNotificationScreenState();
}

class _AlarmNotificationScreenState extends State<AlarmNotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Alram is ringing.......'),

              Text(widget.alarmSettings.id.toString()),

              Text(widget.alarmSettings.notificationSettings.title),

              Text(widget.alarmSettings.notificationSettings.body),

              //

              ElevatedButton(
                onPressed: () {
                  Alarm.stop(widget.alarmSettings.id).then(
                    // ignore: use_build_context_synchronously
                    (_) => Navigator.pop(context),
                  );
                },
                child: const Text('Stop'),
              ),

              //
            ],
          ),
        ),
      ),
    );
  }
}
