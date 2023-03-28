import 'package:emart_app/cart_screen/Cart_screen.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/model/CatogorisModel.dart';
import 'package:firebase_core/firebase_core.dart';

class fierStorServices {
  // get users data
  static getuserid(uid) {
    return firestore
        .collection(usercollection)
        .where('id', isEqualTo: uid)
        .snapshots();
  }

  static getproducts(categoryy) {
    return firestore
        .collection(productCollection)
        .where('p_category', isEqualTo: categoryy)
        .snapshots();
  }

  static getcart(uid) {
    return firestore
        .collection(Cart)
        .where('added_by', isEqualTo: uid)
        .snapshots();
  }

  static DeleateDocument(docId) {
    return firestore.collection(Cart).doc(docId).delete();
  }

  static getCatMessage(docId) {
    return firestore
        .collection(chatcollection)
        .doc(docId)
        .collection(messagecolection)
        .orderBy('created_on', descending: false)
        .snapshots();
  }

  static getAllOrders() {
    return firestore
        .collection(ordersCollection)
        .where('order_by', isEqualTo: currerntuser!.uid)
        .snapshots();
  }

  static getAllWishList() {
    return firestore
        .collection(productCollection)
        .where('p_wishlist', arrayContains: currerntuser!.uid)
        .snapshots();
  }

  static getAllMessage() {
    return firestore
        .collection(chatcollection)
        .where('fromId', isEqualTo: currerntuser!.uid)
        .snapshots();
  }

  static getcount() async {
    var res = await Future.wait([
      firestore
          .collection(Cart)
          .where('added_by', isEqualTo: currerntuser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
      firestore
          .collection(productCollection)
          .where('p_wishlist', arrayContains: currerntuser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
      firestore
          .collection(ordersCollection)
          .where('order_by', isEqualTo: currerntuser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
    ]);
    return res;
  }

  static allproducts() {
    return firestore.collection(productCollection).snapshots();
  }
}
