import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/alarm_setting/alarm_setting.dart';

// ignore: must_be_immutable
class AlarmNotificationScreen extends ConsumerStatefulWidget {
  AlarmNotificationScreen({super.key, required this.alarmSettings});

  AlarmSettings alarmSettings;

  @override
  ConsumerState<AlarmNotificationScreen> createState() =>
      _AlarmNotificationScreenState();
}

class _AlarmNotificationScreenState
    extends ConsumerState<AlarmNotificationScreen> {
  ///
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
                    (_) {
                      ref
                          .read(alarmSettingProvider.notifier)
                          .setFirstMove(flag: false);

                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    },
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
