import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../collections/alarm_collection.dart';
import '../../controllers/alarm_setting/alarm_setting.dart';
import '../../extensions/extensions.dart';
import '../alarm_notification_screen.dart';

class DailyAlarmListAlert extends ConsumerStatefulWidget {
  const DailyAlarmListAlert({super.key, required this.alarmList});

  final List<AlarmCollection> alarmList;

  @override
  ConsumerState<DailyAlarmListAlert> createState() => _DailyAlarmListAlertState();
}

class _DailyAlarmListAlertState extends ConsumerState<DailyAlarmListAlert> {
  late List<AlarmSettings> alarms;

  // ignore: cancel_subscriptions
  static StreamSubscription<AlarmSettings>? subscription;

  ///
  @override
  void initState() {
    super.initState();

    checkAndroidNotificationPermission();

    checkAndroidScheduleExactAlarmPermission();

    loadAlarms();

    subscription ??= Alarm.ringStream.stream.listen(navigateToRingScreen);
  }

  ///
  Future<void> checkAndroidNotificationPermission() async {
    final PermissionStatus status = await Permission.notification.status;

    if (status.isDenied) {
      alarmPrint('Requesting notification permission...');

      final PermissionStatus res = await Permission.notification.request();

      alarmPrint(
        'Notification permission ${res.isGranted ? '' : 'not '}granted',
      );
    }
  }

  ///
  Future<void> checkAndroidScheduleExactAlarmPermission() async {
    final PermissionStatus status = await Permission.scheduleExactAlarm.status;

    if (kDebugMode) {
      print('Schedule exact alarm permission: $status.');
    }

    if (status.isDenied) {
      if (kDebugMode) {
        print('Requesting schedule exact alarm permission...');
      }

      final PermissionStatus res = await Permission.scheduleExactAlarm.request();

      if (kDebugMode) {
        print('Schedule exact alarm permission ${res.isGranted ? '' : 'not'} granted.');
      }
    }
  }

  ///
  void loadAlarms() {
    setState(() {
      alarms = Alarm.getAlarms();

      alarms.sort((AlarmSettings a, AlarmSettings b) => a.dateTime.isBefore(b.dateTime) ? 0 : 1);
    });
  }

  ///
  Future<void> navigateToRingScreen(AlarmSettings alarmSettings) async {
    await Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => AlarmNotificationScreen(alarmSettings: alarmSettings),
      ),
    );

    loadAlarms();
  }

  ///
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final bool firstMove = ref.watch(alarmSettingProvider.select((AlarmSettingState value) => value.firstMove));

      if (!firstMove) {
        if (alarms.isEmpty) {
          Navigator.pop(context);
        }
      }
    });

    return Scaffold(
      //

      backgroundColor: Colors.transparent,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  // ignore: always_specify_types
                  children: List.generate(
                    alarms.length,
                    (int index) => Text(
                      alarms[index].dateTime.toString(),
                      style: const TextStyle(
                        fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
                      ),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  for (final AlarmCollection element in widget.alarmList) {
                    final DateTime dateTime = DateTime(
                      element.date.split('-')[0].toInt(),
                      element.date.split('-')[1].toInt(),
                      element.date.split('-')[2].toInt(),
                      element.time.split(':')[0].toInt(),
                      element.time.split(':')[1].toInt(),
                    );

                    setAlarm(
                      alarmId: element.id,
                      alarmDateTime: dateTime,
                      title: element.title,
                      description: element.description,
                    );
                  }
                },
                child: const Text('set'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Future<void> setAlarm({
    required int alarmId,
    required DateTime alarmDateTime,
    required String title,
    required String description,
  }) async {
    final AlarmSettings alarmSettings = AlarmSettings(
      id: alarmId,
      dateTime: alarmDateTime,
      assetAudioPath: 'assets/sounds/blank.mp3',
      // ignore: avoid_redundant_argument_values
      loopAudio: true,
      // ignore: avoid_redundant_argument_values
      vibrate: true,
      fadeDuration: 3.0,
      notificationSettings: NotificationSettings(title: title, body: description),
    );

    await Alarm.set(alarmSettings: alarmSettings);

    loadAlarms();
  }

  ///
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    properties.add(
      DiagnosticsProperty<StreamSubscription<AlarmSettings>?>(
        'subscription',
        subscription,
      ),
    );
  }
}
