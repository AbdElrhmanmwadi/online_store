// ignore_for_file: prefer_const_constructors

import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/homecontroller.dart';
import 'package:emart_app/views/home_screen/Account_screen/Account_screen.dart';
import 'package:emart_app/cart_screen/Cart_screen.dart';
import 'package:emart_app/views/home_screen/catogers_scrren/Catrgoris_screen.dart';
import 'package:emart_app/views/home_screen/home_screen/home_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var index = 0;
  var fbm = FirebaseMessaging.instance;
  @override
  void initState() {
    fbm.getToken().then((value) {
      print('*****************************');
      print(value);
      print('*****************************');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(Homecontroller());
// Listen for changes on the controller

    var navbarItem = [
      BottomNavigationBarItem(
          icon: Image.asset(
            icHome,
            width: 26,
          ),
          label: 'Home'),
      BottomNavigationBarItem(
        icon: Image.asset(
          icCategories,
          width: 26,
        ),
        label: 'Catrgoris',
      ),
      BottomNavigationBarItem(
          icon: Image.asset(
            icCart,
            width: 26,
          ),
          label: 'Cart'),
      BottomNavigationBarItem(
          icon: Image.asset(
            icProfile,
            width: 26,
          ),
          label: 'Account'),
    ];
    var navbody = [
      home_screen(),
      Catogoris_screen(),
      cart_screen(),
      Account_screen()
    ];

    return WillPopScope(
      onWillPop: () async {
        Get.defaultDialog(
            barrierDismissible: false,
            buttonColor: redColor,
            title: 'Confirm',
            middleText: 'Are You Sure you want to exit?',
            textCancel: 'yes',
            onCancel: () {
              SystemNavigator.pop();
            },
            textConfirm: 'No',
            onConfirm: () {
              print('Confirm');
              Get.back();
            });
        return false;
      },
      child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: index,
            backgroundColor: whiteColor,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: redColor,
            selectedLabelStyle: TextStyle(fontFamily: semibold),
            items: navbarItem,
            onTap: (value) {
              setState(() {
                index = value;
              });
            },
          ),
          body: navbody[index]),
    );
  }
}
