import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper
{
  static SharedPreferences prefs =  SharedPreferences.getInstance() as SharedPreferences ;

  static init() async
  {
    prefs = await SharedPreferences.getInstance();
  }

  static Future putValue({
    required String key,
    required String value,
  }) async
  {
    return await prefs.setString(key, value);
  }

  static Future putValueList({
    required String key,
    required List<String> value,
  }) async
  {
    return await prefs.setStringList(key, value);
  }

  static  getValue({
    required String key,
  })
  {
    return prefs.getString(key);
  }

  static Future<bool> putBoolean({
    required String key,
    required bool value,
  }) async
  {
    return await prefs.setBool(key, value);
  }

  static  getBoolean({
    required String key,
  })
  {
    return prefs.getBool(key);
  }
}