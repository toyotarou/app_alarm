import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar/isar.dart';

import '../../collections/alarm_collection.dart';
import '../../extensions/extensions.dart';
import '../../repository/alarm_repository.dart';
import '../../state/alarm/alarm.dart';
import 'parts/error_dialog.dart';

class DailyAlarmDisplayAlert extends ConsumerStatefulWidget {
  const DailyAlarmDisplayAlert(
      {super.key,
      required this.date,
      required this.isar,
      required this.alarmMap});

  final DateTime date;
  final Isar isar;

  final Map<String, List<AlarmCollection>> alarmMap;

  @override
  ConsumerState<DailyAlarmDisplayAlert> createState() =>
      _DailyAlarmDisplayAlertState();
}

class _DailyAlarmDisplayAlertState
    extends ConsumerState<DailyAlarmDisplayAlert> {
  final TextEditingController _titleEditingController = TextEditingController();
  final TextEditingController _descriptionEditingController =
      TextEditingController();

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text(widget.date.yyyymmdd), Container()],
              ),
              Divider(color: Colors.white.withOpacity(0.4), thickness: 5),
              _displayInputParts(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(),
                  TextButton(
                    onPressed: () {
                      _inputAlarm();
                    },
                    child: const Text('アラーム設定を追加する',
                        style: TextStyle(fontSize: 12)),
                  ),
                ],
              ),
              Expanded(child: _displayAlarmList()),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget _displayInputParts() {
    final String inputTime =
        ref.watch(alarmProvider.select((AlarmState value) => value.inputTime));

    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
              blurRadius: 24,
              spreadRadius: 16,
              color: Colors.black.withOpacity(0.2)),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
          child: Container(
            width: context.screenSize.width,
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
              border:
                  Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
            ),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: () => _showTP(),
                      icon: const Icon(Icons.timelapse),
                    ),
                    Text((inputTime != '') ? inputTime : '--:--'),
                  ],
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _titleEditingController,
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    hintText: 'タイトル',
                    filled: true,
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white54)),
                  ),
                  style: const TextStyle(fontSize: 13, color: Colors.white),
                  onTapOutside: (PointerDownEvent event) =>
                      FocusManager.instance.primaryFocus?.unfocus(),
                  onChanged: (String value) {
                    if (value != '') {
                      // ref
                      //     .read(bankPriceAdjustProvider.notifier)
                      //     .setAdjustPrice(
                      //     pos: i, value: value.trim().toInt());
                    }
                  },
                ),
                const SizedBox(height: 10),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _descriptionEditingController,
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    hintText: '内容',
                    filled: true,
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white54)),
                  ),
                  style: const TextStyle(fontSize: 13, color: Colors.white),
                  onTapOutside: (PointerDownEvent event) =>
                      FocusManager.instance.primaryFocus?.unfocus(),
                  maxLines: 5,
                  onChanged: (String value) {
                    if (value != '') {
                      // ref
                      //     .read(bankPriceAdjustProvider.notifier)
                      //     .setAdjustPrice(
                      //     pos: i, value: value.trim().toInt());
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
  Widget _displayAlarmList() {
    final List<Widget> list = <Widget>[];

    widget.alarmMap[widget.date.yyyymmdd]?.forEach((AlarmCollection element) {
      list.add(Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Colors.white.withOpacity(0.3)))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(width: 60, child: Text(element.time)),
                Text(
                  element.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    _showDeleteDialog(id: element.id);
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.white.withOpacity(0.4),
                  ),
                ),
              ],
            )
          ],
        ),
      ));
    });

    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) => list[index],
            childCount: list.length,
          ),
        ),
      ],
    );
  }

  ///
  Future<void> _showTP() async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 8, minute: 0),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child ?? Container(),
        );
      },
    );

    if (selectedTime != null) {
      final String time =
          '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}';

      await ref.read(alarmProvider.notifier).setInputTime(time: time);
    }
  }

  ///
  Future<void> _inputAlarm() async {
    bool errFlg = false;

    if (_titleEditingController.text.trim() == '' ||
        _descriptionEditingController.text.trim() == '') {
      errFlg = true;
    }

    final String inputTime =
        ref.watch(alarmProvider.select((AlarmState value) => value.inputTime));

    if (inputTime == '') {
      errFlg = true;
    }

    final DateTime dateTime1 = DateTime(
      widget.date.yyyymmdd.split('-')[0].toInt(),
      widget.date.yyyymmdd.split('-')[1].toInt(),
      widget.date.yyyymmdd.split('-')[2].toInt(),
      inputTime.split(':')[0].toInt(),
      inputTime.split(':')[1].toInt(),
    );

    if (dateTime1.isBefore(DateTime.now())) {
      errFlg = true;
    }

    if (errFlg) {
      // ignore: always_specify_types
      Future.delayed(
        Duration.zero,
        () => error_dialog(
            // ignore: use_build_context_synchronously
            context: context,
            title: '登録できません。',
            content: '値を正しく入力してください。'),
      );

      return;
    }

    final AlarmCollection alarm = AlarmCollection()
      ..date = widget.date.yyyymmdd
      ..time = inputTime
      ..title = _titleEditingController.text.trim()
      ..description = _descriptionEditingController.text.trim()
      ..alarmOn = 0;

    await AlarmRepository()
        .inputAlarm(isar: widget.isar, alarm: alarm)
        // ignore: always_specify_types
        .then((value) {
      _titleEditingController.clear();
      _descriptionEditingController.clear();

      if (mounted) {
        Navigator.pop(context);
      }
    });
  }

  ///
  void _showDeleteDialog({required int id}) {
    final Widget cancelButton = TextButton(
        onPressed: () => Navigator.pop(context), child: const Text('いいえ'));

    final Widget continueButton = TextButton(
        onPressed: () {
          _deleteAlarm(id: id);

          Navigator.pop(context);
        },
        child: const Text('はい'));

    final AlertDialog alert = AlertDialog(
      backgroundColor: Colors.blueGrey.withOpacity(0.3),
      content: const Text('このデータを消去しますか？'),
      actions: <Widget>[cancelButton, continueButton],
    );

    // ignore: inference_failure_on_function_invocation
    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  ///
  Future<void> _deleteAlarm({required int id}) async => AlarmRepository()
          .deleteAlarm(isar: widget.isar, id: id)
          // ignore: always_specify_types
          .then((value) {
        if (mounted) {
          Navigator.pop(context);
        }
      });
}
