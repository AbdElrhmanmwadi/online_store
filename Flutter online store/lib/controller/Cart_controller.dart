import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/homecontroller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var totaIp = 0.obs;
  // text controller for Shipping details
  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var postalCodeController = TextEditingController();
  var phoneController = TextEditingController();

  // payment
  var paymentIndex = 0.obs;

  late dynamic productSnapshot;
  var products = [];
  var placingOreder = false.obs;

  calculate(data) {
    totaIp.value = 0;
    for (var i = 0; i < data.length; i++) {
      totaIp.value = totaIp.value + int.parse(data[i]['tprice'].toString());
    }
  }

  changepaymentindex(index) {
    paymentIndex.value = index;
  }

  placeMyorder({required orderPaymentMethod, required totalAmount}) async {
    placingOreder(true);
    await getProductDetails();
    await firestore.collection(ordersCollection).doc().set({
      'order_code': "233981237",
      'order_date': FieldValue.serverTimestamp(),
      'order_by': currerntuser!.uid,
      'order_by_name': Get.find<Homecontroller>().username,
      'order_by_email': currerntuser!.email,
      'order_by_address': addressController.text,
      'order_by_state': stateController.text,
      'order_by_city': cityController.text,
      'order_by_phone': phoneController.text,
      'order_by_postalcode': postalCodeController.text,
      'shipping_method': "Home Delivery",
      'payment_method': orderPaymentMethod,
      'order_placed': true,
      'order_confirmed': false,
      'order_delivered': false,
      'order_on_delivered': false,
      'total_amount': totalAmount,
      'orders': FieldValue.arrayUnion(products)
    });
    placingOreder(false);
  }

  getProductDetails() {
    products.clear();
    for (var i = 0; i < productSnapshot.length; i++) {
      products.add({
        'color': productSnapshot[i]['color'],
        'img': productSnapshot[i]['img'],
        'quantity': productSnapshot[i]['quantity'],
        'tprice': productSnapshot[i]['tprice'],
        'title': productSnapshot[i]['title'],
        'vendor_id': productSnapshot[i]['vendor_id']
      });
    }
    print(products);
  }

  cleareCart() {
    for (var i = 0; i < productSnapshot.length; i++) {
      firestore.collection(Cart).doc(productSnapshot[i].id).delete();
    }
  }
}
