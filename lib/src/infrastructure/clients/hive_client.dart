import 'package:hive/hive.dart';

class HiveClient {
  Future<Box> openBox(String boxName) async {
    if (Hive.isBoxOpen(boxName)) {
      return Hive.box(boxName);
    } else {
      return openBox(boxName);
    }
  }

  Future<dynamic> getData(String boxName, String key) async {
    final Box box = await openBox(boxName);
    return box.get(key);
  }

  Future<void> putData({
    required String boxName,
    required Map<String, dynamic> data,
  }) async {
    final Box box = await openBox(boxName);
    box.putAll(data);
  }
}
