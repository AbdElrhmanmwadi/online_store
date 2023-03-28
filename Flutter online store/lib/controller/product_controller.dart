// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/model/CatogorisModel.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var subcat = [];
  var quantity = 0.obs;
  var colorIndex = 0.obs;
  var totaprice = 0.obs;
  var isFav = false.obs;

  getSubCategories(String title) async {
    // to clear data form list aftter we get it
    // if we dont do that he will stor all data in list and
    // display it
    subcat.clear();
    var data = await rootBundle.loadString("lib/siervses/catorgry_model.json");
    var decoded = catrgoridModelFromJson(data);
    var s =
        decoded.categories.where((element) => element.name == title).toList();
    for (var e in s[0].subcategory) {
      subcat.add(e);
    }
  }

  Changecolorindex(index) {
    colorIndex.value = index;
  }

  incressquntile(totalquntile) {
    if (quantity.value < totalquntile) {
      quantity.value++;
    }
  }

  decreasquntile() {
    if (quantity.value > 0) {
      quantity.value--;
    }
  }

  calucolateprice(price) {
    totaprice.value = price * quantity.value;
  }

  addProduct(
      {categoryName,
      color,
      desc,
      imag,
      prdName,
      price,
      qty,
      rating,
      seller,
      subcactegory,
      whislist,
      vendor_id}) async {
    await firestore.collection(productCollection).add({
      'p_category': categoryName,
      'p_color': color,
      'p_describtion': desc,
      'p_imgs': imag,
      'p_name': prdName,
      'p_price': price,
      'p_quantity': qty,
      'p_rating': rating,
      'p_seller': seller,
      'p_subcategory': subcactegory,
      'p_wishlist': whislist,
      'vendor_id': vendor_id,
    });
  }

  addToCart({title, img, sellername, color, tquntile, tprice, vendorID}) async {
    await firestore.collection(Cart).doc().set({
      'title': title,
      'img': img,
      'sellername': sellername,
      'color': color,
      'quantity': tquntile,
      'vendor_id': vendorID,
      'tprice': tprice,
      'added_by': currerntuser!.uid
    }).catchError((onError) {
      Get.snackbar('Error', 'Add to Cart faild');
    });
  }

  restvalue() {
    totaprice.value = 0;
    quantity.value = 0;
    colorIndex.value = 0;
  }

  addtowshlist(docId) async {
    await firestore.collection(productCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayUnion([currerntuser!.uid])
    }, SetOptions(merge: true));
    isFav(true);
  }

  removeFromWshlist(docId) async {
    await firestore.collection(productCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayRemove([currerntuser!.uid])
    }, SetOptions(merge: true));
    isFav(false);
  }

  chekifva(data) async {
    if (data['p_wishlist'].contains(currerntuser!.uid)) {
      isFav(true);
    } else {
      isFav(false);
    }
  }
}
