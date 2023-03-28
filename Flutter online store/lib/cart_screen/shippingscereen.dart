// ignore_for_file: prefer_const_constructors

import 'package:emart_app/cart_screen/payment_metode.dart';
import 'package:emart_app/consts/colors.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/Cart_controller.dart';
import 'package:emart_app/widgets/custom_textfiled.dart';
import 'package:emart_app/widgets/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShippingDeatils extends StatelessWidget {
  ShippingDeatils({super.key});
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Shipping Info',
          style: TextStyle(color: darkFontGrey, fontFamily: semibold),
        ),
      ),
      bottomNavigationBar: SizedBox(
          height: 60,
          child: ourbutton(
              color: redColor,
              title: 'Continue',
              onpressed: () {
                if (formkey.currentState!.validate()) {
                  Get.to(() => paymentMethods());
                }
              })),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Form(
          key: formkey,
          child: Column(
            children: [
              custom_textfield(
                validator: (value) {
                  if (value!.length > 100) {
                    return 'Address cant to be larger than 100 letter';
                  }
                  if (value.length <= 0) {
                    return 'Address cant to Empty';
                  }
                  return null;
                },
                name_filed: 'Address',
                hinttext: 'Address',
                controller: controller.addressController,
              ),
              custom_textfield(
                validator: (value) {
                  if (value!.length > 100) {
                    return 'Address cant to be larger than 100 letter';
                  }
                  if (value.length <= 0) {
                    return 'Address cant to Empty';
                  }
                  return null;
                },
                name_filed: 'City',
                hinttext: 'City',
                controller: controller.cityController,
              ),
              custom_textfield(
                validator: (value) {
                  if (value!.length > 100) {
                    return 'Address cant to be larger than 100 letter';
                  }
                  if (value.length <= 0) {
                    return 'Address cant to Empty';
                  }
                  return null;
                },
                name_filed: 'State',
                hinttext: 'State',
                controller: controller.stateController,
              ),
              custom_textfield(
                name_filed: 'postal Code',
                hinttext: 'postal Code',
                controller: controller.postalCodeController,
              ),
              custom_textfield(
                name_filed: 'Phone',
                hinttext: 'Phone',
                controller: controller.phoneController,
              )
            ],
          ),
        ),
      ),
    );
  }
}
