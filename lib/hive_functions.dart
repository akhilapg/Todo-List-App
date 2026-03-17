import 'package:hive_flutter/hive_flutter.dart';
import 'hive_box_const.dart';

class HiveFunctions {
  // box which will use to store the things

  static final taskStorageBoxForLocalStorage = Hive.box(userHiveBox);
  static createTask(Map data) {
    taskStorageBoxForLocalStorage.add(data);
    print("this is from hive${taskStorageBoxForLocalStorage.values}");
  }
  //get all data stored in hive
static getAllTasks() {
    print("calling started");
    final data = taskStorageBoxForLocalStorage.keys.map((key) {
      final value = taskStorageBoxForLocalStorage.get(key);
      print(value);
    });
print(data);
}
}