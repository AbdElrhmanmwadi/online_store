// ignore_for_file: prefer_const_constructors

import 'package:emart_app/controller/changethem.dart';
import 'package:emart_app/views/auth_screen/onpording.dart';
import 'package:emart_app/views/auth_screen/singup_screen.dart';
import 'package:emart_app/views/home_screen/Home.dart';
import 'package:emart_app/views/auth_screen/login_screen.dart';
import 'package:emart_app/views/splach_screen/Splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'consts/consts.dart';

// مراجعة الاشعارات و تعديل الصورة وتغير كلمة السر

// SharedPreferences? sharedPreferences;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // use shared prefrences or get storage
  // sharedPreferences = await SharedPreferences.getInstance();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      theme: ThemeData(
        dialogTheme: DialogTheme(backgroundColor: golden),
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent),
        fontFamily: regular,
      ),
      // home: splcahScreen(),
      initialRoute: '/',
      // he will open the splacah screen and then opern Auth middleweare
      getPages: [
        GetPage(
          name: '/', page: () => splcahScreen(),
          // ransition: Transition.fade,
          // transitionDuration: Duration(seconds: 5),
          // middlewares: [Auth_Middleweare()]
        ),
        GetPage(name: '/home', page: () => Home()),
        GetPage(name: '/login', page: () => login_screen())
      ],
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: const ColorScheme.dark().copyWith(
          primary: Color.fromARGB(255, 31, 28, 29),
          secondary: Color.fromARGB(255, 230, 224, 221),
        ),

        cardColor: Colors.white,

        listTileTheme: ListTileThemeData(
            tileColor: Colors.white,
            iconColor: whiteColor,
            dense: false,
            textColor: whiteColor),
        bottomNavigationBarTheme:
            BottomNavigationBarThemeData(unselectedItemColor: Colors.green),

        primaryColor: Colors.white,
        primaryColorDark: Colors.black,
        splashColor: const Color(0xffffB59B),
        appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromARGB(255, 32, 31, 31),
            foregroundColor: Colors.white),
        // backgroundColor: const Color(0xff312f2f),
        textTheme: ThemeData.dark().textTheme.copyWith(),
        textSelectionTheme: const TextSelectionThemeData(
          selectionColor: Color.fromARGB(255, 236, 230, 227),
        ),
      ),
      themeMode: Mylocalcontroller_changeTehme().themeColor(),
    );
  }
}
