// ignore_for_file: prefer_const_constructors

import 'package:emart_app/consts/colors.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/Auth_Medle.dart';
import 'package:emart_app/views/auth_screen/onpording.dart';
import 'package:emart_app/views/home_screen/Home.dart';
import 'package:emart_app/views/auth_screen/login_screen.dart';
import 'package:emart_app/widgets/applogo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:emart_app/consts/images.dart';
import 'package:get/get.dart';

var user = FirebaseAuth.instance.currentUser;

class splcahScreen extends StatefulWidget {
  const splcahScreen({super.key});

  @override
  State<splcahScreen> createState() => _splcahScreenState();
}

class _splcahScreenState extends State<splcahScreen> {
  changScreen(context) {
    Future.delayed(Duration(seconds: 3), () {
      auth.authStateChanges().listen((event) {
        if (event == null && mounted) {
          Get.to(() => login_screen());
        } else {
          Get.to(() => Home());
        }
      });
    });
  }

  @override
  void initState() {
    changScreen(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white70, Colors.white, Colors.white],
          stops: [0.2, 0.4, 0.9],
        ),
      ),
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  icSplashBg,
                  width: 300,
                ),
              ),
              applogowidget(),
              SizedBox(
                height: 10,
              ),
              Text(appname,
                  style: TextStyle(
                      color: Colors.black, fontFamily: bold, fontSize: 20)),
              SizedBox(
                height: 5,
              ),
              Text(
                appversion,
                style: TextStyle(color: Colors.black),
              ),
              Spacer(),
              Text(credits,
                  style: TextStyle(color: Colors.black, fontFamily: semibold)),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
