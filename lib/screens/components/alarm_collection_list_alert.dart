import 'package:alarm/alarm.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar/isar.dart';

import '../../collections/alarm_collection.dart';
import '../../extensions/extensions.dart';
import '../../repository/alarm_repository.dart';

class AlarmCollectionListAlert extends ConsumerStatefulWidget {
  const AlarmCollectionListAlert({super.key, required this.isar});

  final Isar isar;

  @override
  ConsumerState<AlarmCollectionListAlert> createState() => _AlarmCollectionListAlertState();
}

class _AlarmCollectionListAlertState extends ConsumerState<AlarmCollectionListAlert> {
  List<AlarmCollection>? alarmCollectionList = <AlarmCollection>[];

  Map<String, List<AlarmCollection>> alarmMap = <String, List<AlarmCollection>>{};

  late List<AlarmSettings> alarms;

  List<String> alarmDateList = <String>[];

  ///
  @override
  void initState() {
    super.initState();

    loadAlarms();
  }

  ///
  void loadAlarms() {
    setState(() {
      alarms = Alarm.getAlarms();

      alarms.sort((AlarmSettings a, AlarmSettings b) => a.dateTime.isBefore(b.dateTime) ? 0 : 1);
    });
  }

  ///
  void _init() {
    _makeAlarmCollectionList();
  }

  ///
  @override
  Widget build(BuildContext context) {
    // ignore: always_specify_types
    Future(_init);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: DefaultTextStyle(
          style: GoogleFonts.kiwiMaru(fontSize: 12),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20),
              Container(width: context.screenSize.width),
              Expanded(child: displayAlarmCollectionList()),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget displayAlarmCollectionList() {
    final List<Widget> list = <Widget>[];

    final List<int> alarmIdList = <int>[];
    for (final AlarmSettings element in alarms) {
      alarmIdList.add(element.id);
    }

    alarmDateList.sort((String a, String b) => a.compareTo(b) * -1);

    for (final String element in alarmDateList) {
      final List<Widget> list2 = <Widget>[];
      alarmMap[element]?.forEach((AlarmCollection element2) {
        list2.add(Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3)))),
          child: Row(
            children: <Widget>[
              SizedBox(width: 40, child: Text(element2.time)),
              const SizedBox(width: 10),
              Expanded(child: Text(element2.title, maxLines: 1, overflow: TextOverflow.ellipsis)),
              SizedBox(
                width: 30,
                child: Icon(
                  Icons.timelapse,
                  color: (alarmIdList.contains(element2.id)) ? Colors.yellowAccent : Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),
        ));
      });

      final String youbi =
          DateTime(element.split('-')[0].toInt(), element.split('-')[1].toInt(), element.split('-')[2].toInt())
              .youbiStr;

      list.add(Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(color: Colors.yellowAccent.withOpacity(0.1)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(element),
                    Row(children: <Widget>[Text(youbi), const SizedBox(width: 10)]),
                  ],
                ),
              ),
            ),
            Expanded(child: Container()),
          ],
        ),
      ));

      list.add(Column(children: list2));
    }

    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) => list[index], childCount: list.length),
        ),
      ],
    );
  }

  ///
  Future<void> _makeAlarmCollectionList() async {
    alarmCollectionList = <AlarmCollection>[];
    alarmMap = <String, List<AlarmCollection>>{};

    await AlarmRepository().getAlarmList(isar: widget.isar).then((List<AlarmCollection>? value) {
      if (mounted) {
        setState(() {
          alarmCollectionList = value;

          if (value!.isNotEmpty) {
            for (final AlarmCollection element in value) {
              alarmMap[element.date] = <AlarmCollection>[];
            }
            for (final AlarmCollection element in value) {
              alarmMap[element.date]?.add(element);

              if (!alarmDateList.contains(element.date)) {
                alarmDateList.add(element.date);
              }
            }
          }
        });
      }
    });
  }
}
