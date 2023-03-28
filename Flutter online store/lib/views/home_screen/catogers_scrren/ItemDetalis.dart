// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/colors.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/product_controller.dart';
import 'package:emart_app/views/chat/chat_screen.dart';
import 'package:emart_app/widgets/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

var ItemDeatalsbuttonlist = [
  'Video',
  'Reviews',
  'Seller Policy',
  'Return Policy',
  ' Support policy'
];

class ItemDetails extends StatelessWidget {
  final title;
  final dynamic data;
  const ItemDetails({super.key, required this.title, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return WillPopScope(
      onWillPop: () async {
        controller.restvalue();
        return true;
      },
      child: Container(
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
            title: Text(
              title,
              style: TextStyle(color: whiteColor, fontFamily: bold),
            ),
            elevation: 0,
            leading: BackButton(
              onPressed: () {
                controller.restvalue();
                Get.back();
              },
              color: whiteColor,
            ),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.share,
                    color: whiteColor,
                  )),
              Obx(
                () => IconButton(
                    onPressed: () {
                      if (controller.isFav.value) {
                        controller.removeFromWshlist(data.id);
                      } else {
                        controller.addtowshlist(data.id);
                      }
                    },
                    icon: Icon(
                      Icons.favorite,
                      color: controller.isFav.value ? redColor : whiteColor,
                    )),
              ),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                  child: Padding(
                padding: EdgeInsets.all(8),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      VxSwiper.builder(
                        viewportFraction: 1.0,
                        autoPlay: true,
                        itemCount: data['p_imgs'].length,
                        height: 250,
                        aspectRatio: 16 / 9,
                        itemBuilder: (context, index) {
                          return Image.network(
                            data['p_imgs'][index],
                            width: double.infinity,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 16,
                            color: darkFontGrey,
                            fontFamily: semibold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      VxRating(
                        isSelectable: false,
                        value: double.parse(data['p_rating']),
                        onRatingUpdate: (value) {},
                        normalColor: textfieldGrey,
                        selectionColor: Colors.yellow,
                        count: 5,
                        maxRating: 5,
                        size: 25,
                        stepInt: true,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${data['p_price']}'.numCurrency,
                        style: TextStyle(
                            fontSize: 18, color: redColor, fontFamily: bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        height: 70,
                        color: textfieldGrey,
                        child: Row(
                          children: [
                            Expanded(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Seller ',
                                  style: TextStyle(
                                      fontFamily: semibold, color: whiteColor),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '${data['p_seller']}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: semibold,
                                      color: darkFontGrey),
                                ),
                              ],
                            )),
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.message,
                                color: darkFontGrey,
                              ),
                            ).onTap(() {
                              Get.to(ChatScreen(), arguments: [
                                data['p_seller'],
                                data['vendor_id']
                              ]);
                            })
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Card(
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Obx(
                            () => Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      child: Text(
                                        'Color',
                                        style: TextStyle(color: redColor),
                                      ),
                                    ),
                                    Row(
                                      children: List.generate(
                                        data['p_color'].length,
                                        (index) => Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            VxBox()
                                                .roundedFull
                                                .size(40, 40)
                                                .color(Color(
                                                        data['p_color'][index])
                                                    .withOpacity(1))
                                                .margin(EdgeInsets.symmetric(
                                                    horizontal: 4))
                                                .make()
                                                .onTap(() {
                                              controller.Changecolorindex(
                                                  index);
                                            }),
                                            Visibility(
                                              child: Icon(
                                                Icons.done,
                                                color: Colors.white,
                                              ),
                                              visible: index ==
                                                  controller.colorIndex.value,
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      child: Text(
                                        'Quantity',
                                        style: TextStyle(color: redColor),
                                      ),
                                    ),
                                    Obx(
                                      () => Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                controller.decreasquntile();
                                                controller.calucolateprice(
                                                    int.parse(data['p_price']));
                                              },
                                              icon: Icon(Icons.remove)),
                                          Text(
                                            '${controller.quantity.value}',
                                            style: TextStyle(
                                                color: darkFontGrey,
                                                fontFamily: bold),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                controller.incressquntile(
                                                    int.parse(
                                                        data['p_quantity']));
                                                controller.calucolateprice(
                                                    int.parse(data['p_price']));
                                              },
                                              icon: Icon(Icons.add)),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            '${data['p_quantity']} available',
                                            style:
                                                TextStyle(color: textfieldGrey),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      child: Text(
                                        'Total',
                                        style: TextStyle(color: redColor),
                                      ),
                                    ),
                                    Text(
                                      '${controller.totaprice.value}'
                                          .numCurrency,
                                      style: TextStyle(
                                          color: redColor, fontFamily: bold),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // describtion section
                      Text(
                        'Description',
                        style: TextStyle(
                            color: darkFontGrey, fontFamily: semibold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${data['p_describtion']}',
                        style: TextStyle(
                          color: darkFontGrey,
                          fontFamily: semibold,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      ListView(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: List.generate(
                              ItemDeatalsbuttonlist.length,
                              (index) => Card(
                                    child: ListTile(
                                      dense: true,
                                      title: Text(
                                        ItemDeatalsbuttonlist[index],
                                        style: TextStyle(
                                            color: darkFontGrey,
                                            fontFamily: semibold),
                                      ),
                                      trailing: Icon(Icons.arrow_forward),
                                    ),
                                  ))),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'product you may also like',
                        style: TextStyle(
                            color: darkFontGrey,
                            fontFamily: semibold,
                            fontSize: 16),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // this is copy from home_screen
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            6,
                            (index) => Container(
                              margin: EdgeInsets.symmetric(horizontal: 4),
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    imgP1,
                                    width: 150,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'laptop 4GB/64GB',
                                    style: TextStyle(
                                        color: darkFontGrey,
                                        fontFamily: semibold),
                                  ),
                                  Text(
                                    '\$600.000',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: redColor,
                                        fontFamily: bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ourbutton(
                    color: redColor,
                    title: 'Add to cart',
                    onpressed: () {
                      if (controller.quantity.value > 0) {
                        controller.addToCart(
                            color: data['p_color'][controller.colorIndex.value],
                            img: data['p_imgs'][0],
                            tquntile: controller.quantity.value,
                            sellername: data['p_seller'],
                            title: data['p_name'],
                            tprice: controller.totaprice.value,
                            vendorID: data['vendor_id']);
                        Get.snackbar('successful', 'Added to Cart done');
                      } else {
                        Get.snackbar('faild', 'Quantity cant be 0');
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
