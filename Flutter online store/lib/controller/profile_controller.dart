// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/views/home_screen/Account_screen/edit_Account_screen.dart';
import 'package:emart_app/views/splach_screen/Splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ProfileContoller extends GetxController {
  var profileImagePath = ''.obs;
  var nameController = TextEditingController();
  var oldpasswordController = TextEditingController();
  var newpasswordController = TextEditingController();
  var ProfileImageLink = '';
  var isloading = false.obs;

  // uplodadimages() async {
  //   var imagepicked = await imagepaicker.pickImage(source: ImageSource.camera);
  //   if (imagepicked != null) {
  //     // full path of image
  //     file = File(imagepicked.path);
  //     // name of image
  //     nameimage = basename(imagepicked.path);
  //     var random = Random().nextInt(1000000000);
  //     nameimage = '$random$nameimage';
  //     print('**********************************');

  //     print(nameimage);
  //     // start Upload
  //     // path of image in cloud storge

  //     // print('url : $url');
  //     // end Upload
  //   } else {
  //     print('Please choose Image');
  //   }
  // }

  ChangeImage() async {
    final img = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 70);
    if (img != null) {
      profileImagePath.value = img.path;
    }
  }

  Updateprofile({name, password, imgUrl}) async {
    var store = firestore.collection(usercollection).doc(currerntuser!.uid);
    // or update
    await store.set({
      'name': name,
      'password': password,
      'imageUrl': imgUrl,
    }, SetOptions(merge: true));
    isloading(false);
    print(imgUrl + '11111111111111111111image url');
  }

  UplodProfileImage() async {
    var filename = basename(profileImagePath.value);
    var destination = 'images/${currerntuser!.uid}/$filename';
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(profileImagePath.value));
    ProfileImageLink = await ref.getDownloadURL();
    print(ProfileImageLink + '22222222222222222222profile image link');
  }

  ChaneAuthPassword({email, password, newpassword}) async {
    final cred =
        await EmailAuthProvider.credential(email: email, password: password);
    await currerntuser!.reauthenticateWithCredential(cred).then((value) {
      currerntuser!.updatePassword(newpassword);
    }).catchError((onError) {
      print(onError.toString());
    });
  }
}
