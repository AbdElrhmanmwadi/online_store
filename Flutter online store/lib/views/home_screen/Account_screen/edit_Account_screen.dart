// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/profile_controller.dart';
import 'package:emart_app/views/auth_screen/singup_screen.dart';
import 'package:emart_app/views/home_screen/Account_screen/addProduct.dart';

import 'package:emart_app/widgets/custom_textfiled.dart';
import 'package:emart_app/widgets/our_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import '../../../controller/changethem.dart';

////////////////////////////////////////////// vedio 111111111111111111111 acount
class edit_Account extends StatefulWidget {
  final dynamic data;
  edit_Account({
    super.key,
    required this.data,
  });

  @override
  State<edit_Account> createState() => _edit_AccountState();
}

class _edit_AccountState extends State<edit_Account> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  // for image and file
  getImagesandFolderName() async {
    var ref = await FirebaseStorage.instance
        .ref('images')
        .list(ListOptions(maxResults: 2));
    ref.items.forEach((element) {
      print('//////////////////////////');
      print(element.name);
      print(element.fullPath);
    });
    // to get name of folder
    ref.prefixes.forEach((element) {
      print('//////////////////////////');
      print(element.name);
    });
  }

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileContoller>();
    controller:
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
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
          elevation: 0,
          actions: [
            MaterialButton(
              onPressed: () {
                Mylocalcontroller_changeTehme().changethem();
                print('object');
              },
              child: Switch(
                  value: Mylocalcontroller_changeTehme().getThemMode(),
                  onChanged: (value) {
                    setState(() {
                      Mylocalcontroller_changeTehme().changethem();
                    });
                  }),
            ),
          ],
        ),
        body: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          margin: EdgeInsets.only(top: 50, left: 12, right: 12),
          child: Obx(
            () => Container(
              padding: EdgeInsets.all(16),
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onLongPress: () {
                      Get.dialog(
                        Container(
                          child: Center(
                            child: Hero(
                              tag: 'imgetag',
                              child: CircleAvatar(
                                backgroundColor: whiteColor,
                                // if controller is Empty and imgeurl is Empty
                                backgroundImage: controller
                                            .profileImagePath.isEmpty &&
                                        widget.data['imageUrl'] == ''
                                    ? AssetImage(
                                        'assets/images/imageprofile.jpg',
                                      )
                                    // if imageurl is not empty and controller is Empty
                                    : widget.data['imageUrl'] != '' &&
                                            controller.profileImagePath.isEmpty
                                        ? NetworkImage(widget.data['imageUrl'])
                                        // // if imageurl is  empty and controller is not Empty
                                        : FileImage(File(controller
                                            .profileImagePath
                                            .value)) as ImageProvider,
                                radius: 150,
                              ),
                            ),
                          ),
                        ),
                      );
                      Future.delayed(Duration(seconds: 1), () {
                        Get.back();
                      });
                    },
                    child: Hero(
                      tag: 'imgetag',
                      child: CircleAvatar(
                        backgroundColor: whiteColor,
                        // if controller is Empty and imgeurl is Empty
                        backgroundImage: controller.profileImagePath.isEmpty &&
                                widget.data['imageUrl'] == ''
                            ? AssetImage(
                                'assets/images/imageprofile.jpg',
                              )
                            // if imageurl is not empty and controller is Empty
                            : widget.data['imageUrl'] != '' &&
                                    controller.profileImagePath.isEmpty
                                ? NetworkImage(widget.data['imageUrl'])
                                // // if imageurl is  empty and controller is not Empty
                                : FileImage(
                                        File(controller.profileImagePath.value))
                                    as ImageProvider,
                        radius: 30,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 100,
                    child: ourbutton(
                      color: redColor,
                      title: 'Change',
                      onpressed: () {
                        controller.ChangeImage();
                        // uplodadimages();
                        // sowbottomshett(context: context);
                      },
                    ),
                  ),
                  Divider(),
                  SizedBox(
                    height: 20,
                  ),
                  Form(
                      key: formkey,
                      child: Column(
                        children: [
                          custom_textfield(
                              controller: controller.nameController,
                              name_filed: 'Name',
                              hinttext: 'Enter your name'),
                          custom_textfield(
                              validator: (value) {
                                if (value.toString() !=
                                    widget.data['password']) {
                                  return 'Wrong password';
                                }
                              },
                              controller: controller.oldpasswordController,
                              name_filed: 'Old password',
                              hinttext: 'Enter old password'),
                          custom_textfield(
                              validator: (value) {
                                if (value!.length > 100) {
                                  return 'password cant to be larger than 100 letter';
                                }
                                if (value.length < 4) {
                                  return 'password cant to be less than 4 letter';
                                }
                                if (value.length == 0) {
                                  return 'password cant to be empty';
                                }
                              },
                              controller: controller.newpasswordController,
                              name_filed: 'New password',
                              hinttext: 'Enter new password'),
                        ],
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  controller.isloading.value
                      ? CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(redColor),
                        )
                      : SizedBox(
                          width: MediaQuery.of(context).size.width - 60,
                          child: ourbutton(
                            color: redColor,
                            title: 'Save',
                            onpressed: () async {
                              if (formkey.currentState!.validate() &&
                                  controller.profileImagePath.isNotEmpty) {
                                controller.isloading(true);

                                await controller.UplodProfileImage();

                                await controller.Updateprofile(
                                    name: controller.nameController.text,
                                    password:
                                        controller.newpasswordController.text,
                                    imgUrl: controller.ProfileImageLink);
                                await controller.ChaneAuthPassword(
                                    newpassword:
                                        controller.newpasswordController.text,
                                    password:
                                        controller.oldpasswordController.text,
                                    email: currerntuser!.email);

                                Get.snackbar('Hi', 'Update is Scusses');
                              } else {
                                Get.snackbar('Hi', 'Update is Faild');
                              }
                            },
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
