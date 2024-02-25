// ignore_for_file: file_names

import 'package:shared_preferences/shared_preferences.dart';

void saveData(key,value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, value);
  // You can also save other data types like int, double, bool, etc.
}