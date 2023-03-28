import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';

class Mylocalcontroller_changeTehme {
  // final shardeprefkey = 'isdark';
  // ////////////// using get storge ///////////////////////////////
  // final _getstorge = GetStorage();
  // ThemeMode getthemmmode() {
  //   return issaveddarkmode() ? ThemeMode.dark : ThemeMode.light;
  // }

  // bool issaveddarkmode() {
  //   return _getstorge.read(shardeprefkey) ?? false;
  //   // return sharedpref!.getBool(shardeprefkey) ?? false;
  // }

  // void save(bool isDarkMode) {
  //   _getstorge.write(shardeprefkey, isDarkMode);
  //   // sharedpref!.setBool(shardeprefkey, isDarkMode);
  // }

  // void changeThemmode() {
  //   Get.changeThemeMode(issaveddarkmode() ? ThemeMode.light : ThemeMode.dark);
  //   save(!issaveddarkmode());
  // }

  final _getStorge = GetStorage();
  String darkKey = 'isDark';
  ThemeMode themeColor() {
    return getThemMode() ? ThemeMode.dark : ThemeMode.light;
  }

  bool getThemMode() {
    return _getStorge.read(darkKey) ?? false;
  }

  void setThemMode(themcolor) {
    _getStorge.write(darkKey, themcolor);
  }

  void changethem() {
    Get.changeThemeMode(getThemMode() ? ThemeMode.light : ThemeMode.dark);
    setThemMode(!getThemMode());
  }
}
