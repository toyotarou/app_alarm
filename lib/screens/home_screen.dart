import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../collections/alarm_collection.dart';
import '../controllers/calendars/calendars_notifier.dart';
import '../controllers/calendars/calendars_response_state.dart';
import '../controllers/holidays/holidays_notifier.dart';
import '../controllers/holidays/holidays_response_state.dart';
import '../extensions/extensions.dart';
import '../repository/alarm_repository.dart';
import '../utilities/utilities.dart';
import 'components/daily_alarm_input_alert.dart';
import 'components/daily_alarm_list_alert.dart';
import 'components/parts/alarm_dialog.dart';

// ignore: must_be_immutable
class HomeScreen extends ConsumerStatefulWidget {
  HomeScreen({super.key, this.baseYm, required this.isar});

  String? baseYm;
  final Isar isar;

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  DateTime _calendarMonthFirst = DateTime.now();
  final List<String> _youbiList = <String>[
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday'
  ];
  List<String> _calendarDays = <String>[];

  Map<String, String> _holidayMap = <String, String>{};

  final Utility _utility = Utility();

  List<AlarmCollection>? alarmList = <AlarmCollection>[];

  Map<String, List<AlarmCollection>> alarmMap =
      <String, List<AlarmCollection>>{};

  ///
  void _init() {
    _makeAlarmList();
  }

  ///
  @override
  Widget build(BuildContext context) {
    // ignore: always_specify_types
    Future(_init);

    if (widget.baseYm != null) {
      // ignore: always_specify_types
      Future(() => ref
          .read(calendarProvider.notifier)
          .setCalendarYearMonth(baseYm: widget.baseYm));
    }

    final CalendarsResponseState calendarState = ref.watch(calendarProvider);

    return Scaffold(
      backgroundColor: Colors.blueGrey.withOpacity(0.3),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Text(calendarState.baseYearMonth),
            const SizedBox(width: 10),
            IconButton(
              onPressed: _goPrevMonth,
              icon: Icon(Icons.arrow_back_ios,
                  color: Colors.white.withOpacity(0.8), size: 14),
            ),
            IconButton(
              onPressed: _goNextMonth,
              icon: Icon(Icons.arrow_forward_ios,
                  color: Colors.white.withOpacity(0.8), size: 14),
            ),
          ],
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
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
          Expanded(child: _getCalendar()),
        ],
      ),
    );
  }

  ///
  Widget _getCalendar() {
    final HolidaysResponseState holidayState = ref.watch(holidayProvider);

    if (holidayState.holidayMap.value != null) {
      _holidayMap = holidayState.holidayMap.value!;
    }

    final CalendarsResponseState calendarState = ref.watch(calendarProvider);

    _calendarMonthFirst =
        DateTime.parse('${calendarState.baseYearMonth}-01 00:00:00');

    final DateTime monthEnd =
        DateTime.parse('${calendarState.nextYearMonth}-00 00:00:00');

    final int diff = monthEnd.difference(_calendarMonthFirst).inDays;
    final int monthDaysNum = diff + 1;

    final String youbi = _calendarMonthFirst.youbiStr;
    final int youbiNum =
        _youbiList.indexWhere((String element) => element == youbi);

    final int weekNum = ((monthDaysNum + youbiNum) <= 35) ? 5 : 6;

    // ignore: always_specify_types
    _calendarDays = List.generate(weekNum * 7, (int index) => '');

    for (int i = 0; i < (weekNum * 7); i++) {
      if (i >= youbiNum) {
        final DateTime gendate =
            _calendarMonthFirst.add(Duration(days: i - youbiNum));

        if (_calendarMonthFirst.month == gendate.month) {
          _calendarDays[i] = gendate.day.toString();
        }
      }
    }

    final List<Widget> list = <Widget>[];
    for (int i = 0; i < weekNum; i++) {
      list.add(_getCalendarRow(week: i));
    }

    return DefaultTextStyle(
        style: const TextStyle(fontSize: 10), child: Column(children: list));
  }

  ///
  Widget _getCalendarRow({required int week}) {
    final List<Widget> list = <Widget>[];

    for (int i = week * 7; i < ((week + 1) * 7); i++) {
      final String generateYmd = (_calendarDays[i] == '')
          ? ''
          : DateTime(_calendarMonthFirst.year, _calendarMonthFirst.month,
                  _calendarDays[i].toInt())
              .yyyymmdd;

      final String youbiStr = (_calendarDays[i] == '')
          ? ''
          : DateTime(_calendarMonthFirst.year, _calendarMonthFirst.month,
                  _calendarDays[i].toInt())
              .youbiStr;

      list.add(
        Expanded(
          child: GestureDetector(
            onTap: (_calendarDays[i] == '')
                ? null
                : () => AlarmDialog(
                      context: context,
                      widget: DailyAlarmInputAlert(
                        date: DateTime.parse('$generateYmd 00:00:00'),
                        isar: widget.isar,
                        alarmMap: alarmMap,
                      ),
                    ),
            child: Container(
              margin: const EdgeInsets.all(1),
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                border: Border.all(
                  color: (_calendarDays[i] == '')
                      ? Colors.transparent
                      : (generateYmd == DateTime.now().yyyymmdd)
                          ? Colors.orangeAccent.withOpacity(0.4)
                          : Colors.white.withOpacity(0.1),
                  width: 3,
                ),
                color: _utility.getYoubiColor(
                    date: generateYmd,
                    youbiStr: youbiStr,
                    holidayMap: _holidayMap),
              ),
              child: (_calendarDays[i] == '')
                  ? const Text('')
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(_calendarDays[i].padLeft(2, '0')),
                            Container(),
                          ],
                        ),
                        const SizedBox(height: 5),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                              minHeight: context.screenSize.height / 10),
                          child: Column(
                            children: displayAlarmList(date: generateYmd),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      );
    }

    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: list);
  }

  ///
  void _goPrevMonth() {
    final CalendarsResponseState calendarState = ref.watch(calendarProvider);

    Navigator.pushReplacement(
      context,
      // ignore: inference_failure_on_instance_creation, always_specify_types
      MaterialPageRoute(
          builder: (BuildContext context) => HomeScreen(
              isar: widget.isar, baseYm: calendarState.prevYearMonth)),
    );
  }

  ///
  void _goNextMonth() {
    final CalendarsResponseState calendarState = ref.watch(calendarProvider);

    Navigator.pushReplacement(
      context,
      // ignore: inference_failure_on_instance_creation, always_specify_types
      MaterialPageRoute(
          builder: (BuildContext context) => HomeScreen(
              isar: widget.isar, baseYm: calendarState.nextYearMonth)),
    );
  }

  ///
  List<Widget> displayAlarmList({required String date}) {
    final List<Widget> list = <Widget>[];

    alarmMap[date]?.forEach((AlarmCollection element) {
      list.add(Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Colors.white.withOpacity(0.3)))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(element.time),
            Container(),
          ],
        ),
      ));
    });

    return list;
  }

  ///
  Future<void> _makeAlarmList() async {
    alarmList = <AlarmCollection>[];
    alarmMap = <String, List<AlarmCollection>>{};

    await AlarmRepository()
        .getAlarmList(isar: widget.isar)
        .then((List<AlarmCollection>? value) {
      if (mounted) {
        setState(() {
          alarmList = value;

          if (value!.isNotEmpty) {
            for (final AlarmCollection element in value) {
              alarmMap[element.date] = <AlarmCollection>[];
            }
            for (final AlarmCollection element in value) {
              alarmMap[element.date]?.add(element);
            }
          }
        });
      }
    });
  }
}
