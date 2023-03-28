// ignore_for_file: prefer_const_constructors

import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/list.dart';
import 'package:emart_app/controller/auth_controller.dart';
import 'package:emart_app/controller/savelogincontrolle.dart';
import 'package:emart_app/views/home_screen/Home.dart';
import 'package:emart_app/views/auth_screen/methodlogin.dart';
import 'package:emart_app/views/auth_screen/singup_screen.dart';

import 'package:emart_app/widgets/applogo.dart';
import 'package:emart_app/widgets/our_button.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../widgets/custom_textfiled.dart';

class login_screen extends StatelessWidget {
  login_screen({super.key});

  @override
  var isloding = false;
  var passwordcontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    Auth_controller controller = Auth_controller();
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white70, Colors.white, Colors.white],
          stops: [0.2, 0.5, 0.9],
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
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
                'Log in to $appname',
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
                  child: Column(
                    children: [
                      Form(
                        key: formkey,
                        child: Obx(
                          () => Column(
                            children: [
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
                                hinttext: 'Enter your password',
                                name_filed: 'password',
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text('Forget password'),
                                  style: TextButton.styleFrom(
                                      foregroundColor: redColor),
                                ),
                              ),
                              controller.islodading.value
                                  ? CircularProgressIndicator(
                                      valueColor:
                                          AlwaysStoppedAnimation(redColor),
                                    )
                                  : ourbutton(
                                      title: 'Log in',
                                      onpressed: () async {
                                        controller.islodading(true);

                                        await controller
                                            .login(
                                                emailcontroller.text,
                                                passwordcontroller.text,
                                                formkey)
                                            .then((value) {
                                          if (value != null) {
                                            SaveController().setstorge();
                                            Get.offAll(Home());
                                          } else {
                                            controller.islodading(false);
                                          }
                                        }).catchError((e) {
                                          print(
                                              ' //////////////////// Error in login  : $e //////////////////////////////');
                                        });
                                      },
                                      color: redColor,
                                    ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Or,create New Account',
                                style: TextStyle(color: fontGrey),
                              ),
                              ourbutton(
                                  color: golden,
                                  title: 'Sing in',
                                  onpressed: () {
                                    Get.off(() => singup_screen());
                                  }),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'log in with',
                                style: TextStyle(color: fontGrey),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                    3,
                                    (index) => GestureDetector(
                                          onTap: () {
                                            signInWithGoogle();
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CircleAvatar(
                                              backgroundColor: lightGrey,
                                              radius: 25,
                                              child: Image.asset(
                                                scoicailIconlist[index],
                                                width: 30,
                                              ),
                                            ),
                                          ),
                                        )),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
