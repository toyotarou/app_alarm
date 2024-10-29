import 'package:isar/isar.dart';

part 'alarm_collection.g.dart';

@collection
class AlarmCollection {
  Id id = Isar.autoIncrement;

  @Index()
  late String date;
  late String time;

  late String title;
  late String description;

  late int alarmOn;
}
