import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar/isar.dart';

import '../../extensions/extensions.dart';
import '../../state/alarm/alarm.dart';

class DailyAlarmDisplayAlert extends ConsumerStatefulWidget {
  const DailyAlarmDisplayAlert(
      {super.key, required this.date, required this.isar});

  final DateTime date;
  final Isar isar;

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
                children: [
                  Container(),
                  TextButton(
                    onPressed: () {},
                    child: const Text('アラーム設定を追加する',
                        style: TextStyle(fontSize: 12)),
                  ),
                ],
              ),

              // Expanded(child: _displayMonthlySpendItemPlaceList()),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget _displayInputParts() {
    final inputTime =
        ref.watch(alarmProvider.select((value) => value.inputTime));

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
                  children: [
                    IconButton(
                      onPressed: () => _showTP(),
                      icon: Icon(Icons.timelapse),
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
                SizedBox(height: 10),
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
}
