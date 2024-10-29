import 'package:isar/isar.dart';

import '../collections/alarm_collection.dart';

class AlarmRepository {
  ///
  IsarCollection<AlarmCollection> getCollection({required Isar isar}) =>
      isar.alarmCollections;

  ///
  Future<AlarmCollection?> getAlarm(
      {required Isar isar, required int id}) async {
    final IsarCollection<AlarmCollection> alarmCollection =
        getCollection(isar: isar);
    return alarmCollection.get(id);
  }

  ///
  Future<List<AlarmCollection>?> getAlarmList({required Isar isar}) async {
    final IsarCollection<AlarmCollection> alarmCollection =
        getCollection(isar: isar);
    return alarmCollection.where().sortByDate().thenByTime().findAll();
  }

  ///
  Future<void> inputAlarm(
      {required Isar isar, required AlarmCollection alarm}) async {
    final IsarCollection<AlarmCollection> alarmCollection =
        getCollection(isar: isar);
    await isar.writeTxn(() async => alarmCollection.put(alarm));
  }

  ///
  Future<void> updateAlarm(
      {required Isar isar, required AlarmCollection alarm}) async {
    final IsarCollection<AlarmCollection> alarmCollection =
        getCollection(isar: isar);
    await alarmCollection.put(alarm);
  }

  ///
  Future<void> deleteAlarm({required Isar isar, required int id}) async {
    final IsarCollection<AlarmCollection> alarmCollection =
        getCollection(isar: isar);
    await isar.writeTxn(() async => alarmCollection.delete(id));
  }
}
