// ignore_for_file: prefer_const_constructors

import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/product_controller.dart';
import 'package:emart_app/views/home_screen/catogers_scrren/catrgory_details.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

var catrgorisimage = [
  imgFc1,
  imgFc2,
  imgFc3,
  imgFc4,
  imgFc5,
  imgFc6,
  imgFc7,
  imgFc8,
  imgFc9,
];
var catrgorislist = [
  'Women Dress',
  'Men Clothing & Fashion',
  'Computer & Accessories',
  'Automobile',
  'Kids & Toys',
  'Sport',
  'Jewelery',
  'Cellphone & Tab',
  'Furniture',
];

class Catogoris_screen extends StatelessWidget {
  const Catogoris_screen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white70, Colors.white, Colors.white],
          stops: [0.2, 0.5, 0.9],
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'Catrgories',
            style: TextStyle(fontFamily: bold, color: whiteColor),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(12),
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: 9,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                mainAxisExtent: 200),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  controller.getSubCategories(catrgorislist[index]);
                  Get.to(() => catrgory_details(title: catrgorislist[index]));
                },
                child: Card(
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Image.asset(
                          catrgorisimage[index],
                          height: 120,
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          catrgorislist[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: darkFontGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
