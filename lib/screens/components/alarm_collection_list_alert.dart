import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar/isar.dart';

import '../../collections/alarm_collection.dart';
import '../../extensions/extensions.dart';

class AlarmCollectionListAlert extends ConsumerStatefulWidget {
  const AlarmCollectionListAlert({
    super.key,
    required this.isar,
    required this.alarmCollectionList,
  });

  final Isar isar;
  final List<AlarmCollection> alarmCollectionList;

  @override
  ConsumerState<AlarmCollectionListAlert> createState() => _AlarmCollectionListAlertState();
}

class _AlarmCollectionListAlertState extends ConsumerState<AlarmCollectionListAlert> {
  ///
  @override
  Widget build(BuildContext context) {
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

    for (final AlarmCollection element in widget.alarmCollectionList) {
      list.add(Text(element.date));
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
}
