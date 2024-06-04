// ignore_for_file: avoid_print

import 'package:shared_preferences/shared_preferences.dart';

class DatabaseService {
  DatabaseService();

  Future<bool?> saveList(String key, List<String> value) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      bool result = await prefs.setStringList(key, value);
      return result;
    } catch (e) {
      print("SharedPreferences Error: $e");
    }
    return false;
  }

  Future<List<String>?> getList(String key) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? result =  prefs.getStringList(key);
      return result;
    } catch (e) {
      print("SharedPreferences Error: $e");
    }
    return null;
  }
}
