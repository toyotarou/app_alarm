import 'package:isar/isar.dart';

part 'alarm.g.dart';

@collection
class Alarm {
  Id id = Isar.autoIncrement;

  @Index()
  late String date;
  late String time;

  late String title;
  late String description;

  late int alarmOn;
}
