// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/colors.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/list.dart';
import 'package:emart_app/controller/auth_controller.dart';
import 'package:emart_app/views/home_screen/Home.dart';
import 'package:emart_app/views/auth_screen/login_screen.dart';
import 'package:emart_app/views/auth_screen/methodlogin.dart';
import 'package:emart_app/widgets/applogo.dart';
import 'package:emart_app/widgets/custom_textfiled.dart';
import 'package:emart_app/widgets/our_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/savelogincontrolle.dart';

class singup_screen extends StatefulWidget {
  const singup_screen({super.key});

  @override
  State<singup_screen> createState() => _singup_screenState();
}

class _singup_screenState extends State<singup_screen> {
  bool? isCheck = false;
  var passwordcontroller = TextEditingController();
  var namecontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var passwordRetypecontroller = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Auth_controller controller = Auth_controller();
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white70, Colors.black54, Colors.white],
          stops: [0.2, 0.4, 0.9],
        ),
      ),
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .1,
                ),
                applogowidget(),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Join the  $appname',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.all(16),
                    width: MediaQuery.of(context).size.width - 70,
                    child: Form(
                      key: formkey,
                      child: Column(
                        children: [
                          Obx(
                            () => Column(children: [
                              custom_textfield(
                                validator: (value) {
                                  if (value!.length > 100) {
                                    return 'user name cant to be larger than 100 letter';
                                  }
                                  if (value.length < 2) {
                                    return 'user name cant to be less than 2 letter';
                                  }
                                  return null;
                                },
                                controller: namecontroller,
                                hinttext: 'Enter your name',
                                name_filed: 'name',
                              ),
                              custom_textfield(
                                validator: (value) {
                                  if (value!.length > 100) {
                                    return 'Email cant to be larger than 100 letter';
                                  }
                                  if (value.length < 2) {
                                    return 'Email cant to be less than 2 letter';
                                  }
                                  return null;
                                },
                                controller: emailcontroller,
                                hinttext: 'Enter your Email',
                                name_filed: 'Email',
                              ),
                              custom_textfield(
                                validator: (value) {
                                  if (value!.length > 100) {
                                    return 'password cant to be larger than 100 letter';
                                  }
                                  if (value.length < 4) {
                                    return 'password cant to be less than 4 letter';
                                  }
                                  return null;
                                },
                                controller: passwordcontroller,
                                hinttext: '*********',
                                name_filed: 'Enter your password',
                              ),
                              custom_textfield(
                                validator: (value) {
                                  if (value != passwordcontroller.text) {
                                    return 'password password is not mhatch';
                                  }

                                  return null;
                                },
                                controller: passwordRetypecontroller,
                                hinttext: '********',
                                name_filed: 'Retype password',
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                    onPressed: () {},
                                    child: Text('Forget password')),
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                      activeColor: redColor,
                                      checkColor: whiteColor,
                                      value: isCheck,
                                      onChanged: (value) {
                                        setState(() {
                                          isCheck = value;
                                        });
                                      }),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Expanded(
                                    child: RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                          text: 'I agree to the ',
                                          style: TextStyle(
                                            fontFamily: bold,
                                            color: fontGrey,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'terms and conditions ',
                                          style: TextStyle(
                                            fontFamily: bold,
                                            color: redColor,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '& ',
                                          style: TextStyle(
                                            fontFamily: bold,
                                            color: fontGrey,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'privacy and policy ',
                                          style: TextStyle(
                                            fontFamily: bold,
                                            color: redColor,
                                          ),
                                        ),
                                      ]),
                                    ),
                                  ),
                                ],
                              ),
                              controller.islodading.value
                                  ? CircularProgressIndicator(
                                      valueColor:
                                          AlwaysStoppedAnimation(redColor),
                                    )
                                  : ourbutton(
                                      title: 'Sing up',
                                      onpressed: () async {
                                        controller.islodading(true);
                                        await controller
                                            .singup(
                                                password:
                                                    passwordcontroller.text,
                                                email: emailcontroller.text,
                                                formkey: formkey,
                                                isCheck: isCheck)
                                            .then((value) {
                                          if (value != null) {
                                            SaveController().setstorge();
                                            print(
                                                '#############################');
                                            print(emailcontroller.text);
                                            print(
                                                '#############################');
                                            return controller.StoreUserData(
                                                    name: namecontroller.text,
                                                    password:
                                                        passwordcontroller.text,
                                                    email: emailcontroller.text)
                                                .then((value) =>
                                                    Get.off(() => Home()))
                                                .catchError((onError) {
                                              print(
                                                  ' //////////////////// Error in store : $e //////////////////////////////');
                                            });
                                          } else {
                                            controller.islodading(false);
                                          }
                                        }).catchError((onError) {
                                          print(
                                              ' //////////////////// Error in singin  : $e //////////////////////////////');
                                        });
                                        // print('#############################');
                                        // print(respons!.user!.email);
                                        // print('#############################');
                                        // if (respons != null) {
                                        //   controller.StoreUserData(
                                        //           name: namecontroller.text,
                                        //           password: passwordcontroller.text,
                                        //           email: emailcontroller.text)
                                        //       .then((value) => Get.off(() => Home()))
                                        //       .catchError((onError) {
                                        //     print('Error : $e');
                                        //   });
                                        // }
                                      },
                                      color: isCheck == true
                                          ? redColor
                                          : lightGrey,
                                    ),
                              SizedBox(
                                height: 5,
                              ),
                              GestureDetector(
                                child: RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                      text: 'Already have an Account? ',
                                      style: TextStyle(color: fontGrey),
                                    ),
                                    TextSpan(
                                      text: 'Log in',
                                      style: TextStyle(
                                          color: redColor, fontFamily: bold),
                                    ),
                                  ]),
                                ),
                                onTap: () {
                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                    builder: (context) => login_screen(),
                                  ));
                                },
                              )
                            ]),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  stordata() async {}
}
