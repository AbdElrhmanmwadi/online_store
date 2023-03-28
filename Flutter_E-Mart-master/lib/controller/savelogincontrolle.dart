import 'package:get_storage/get_storage.dart';

class SaveController {
  final storgekey = 'user';
  final _getstorg = GetStorage();
  setstorge() {
    _getstorg.write(storgekey, '1');
  }

  getstorge() {
    return _getstorg.read(storgekey);
  }

  deleatestorge() {
    _getstorg.remove(storgekey);
  }

  chekstorge() {
    getstorge() == storgekey;
  }
}

// class Mylocalcontroller_changeTehme {
//   final shardeprefkey = 'isdark';
//   ////////////// using get storge ///////////////////////////////
//   // final _getstorge = GetStorage();
//   ThemeMode getthemmmode() {
//     return issaveddarkmode() ? ThemeMode.dark : ThemeMode.light;
//   }

//   bool issaveddarkmode() {
//     // return _getstorge.read(shardeprefkey) ?? false;
//     return sharedpref!.getBool(shardeprefkey) ?? false;
//   }

//   void save(bool isDarkMode) {
//     // _getstorge.write(shardeprefkey, isDarkMode);
//     sharedpref!.setBool(shardeprefkey, isDarkMode);
//   }

//   void changeThemmode() {
//     Get.changeThemeMode(issaveddarkmode() ? ThemeMode.light : ThemeMode.dark);
//     save(!issaveddarkmode());
//   }
// }
