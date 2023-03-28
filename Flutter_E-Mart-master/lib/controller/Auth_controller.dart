// ignore_for_file: non_constant_identifier_names, void_checks

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/views/auth_screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Auth_controller extends GetxController {
  var islodading = false.obs;

  Future<UserCredential?> singup({password, email, formkey, isCheck}) async {
    if (isCheck != false && formkey.currentState!.validate()) {
      try {
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        return credential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Get.snackbar(
            'Hi',
            'password is too weak',
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
          );
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          Get.snackbar(
            'Hi',
            'email already exist',
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
          );
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e.toString());
      }
    } else {
      print('Not vaild ');
    }
  }

  Future StoreUserData({name, password, email}) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'name': name,
      'password': password,
      'email': email,
      'imageUrl': '',
      'id': currerntuser!.uid,
      'cart_count': '00',
      'whishlist_count': '00',
      'order_count': '00',
    });
  }

  singout() async {
    try {
      await auth.signOut();
      print('singout suss');
    } catch (e) {
      print('singout faild');
      print(e.toString());
    }
  }

  Future<UserCredential?> login(email, password, formkey) async {
    UserCredential? credential;
    if (formkey.currentState!.validate()) {
      try {
        // showDialog(
        //     context: context,
        //     builder: (context) {
        //       return Center(
        //         child: CircularProgressIndicator(
        //           valueColor: AlwaysStoppedAnimation(redColor),
        //         ),
        //       );
        //     });
        credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Get.defaultDialog(
            title: 'Error',
            content: Text(
              "No user found for that email..",
            ),
          );

          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          Get.defaultDialog(
            title: "Error",
            content: const Text("Wrong password."),
          );
          print('Wrong password provided for that user.');
        }
      }
    } else {
      print('login Not vaild ');
    }
    return credential;
  }
}
