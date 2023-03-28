// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/product_controller.dart';
import 'package:emart_app/views/home_screen/catogers_scrren/ItemDetalis.dart';
import 'package:emart_app/siervses/fierstor_servises.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class catrgory_details extends StatelessWidget {
  final title;
  const catrgory_details({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
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
            title,
            style: TextStyle(fontFamily: bold, color: whiteColor),
          ),
        ),
        body: StreamBuilder(
          stream: fierStorServices.getproducts(title),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                ),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text(
                  'No Products found!',
                  style: TextStyle(color: Colors.black),
                ),
              );
            } else {
              var data = snapshot.data!.docs;
              return Container(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      child: Row(
                        children: List.generate(
                          controller.subcat.length,
                          (index) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: whiteColor,
                            ),
                            alignment: Alignment.center,
                            width: 150,
                            height: 60,
                            margin: EdgeInsets.symmetric(horizontal: 4),
                            child: Text(
                              "${controller.subcat[index]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: semibold,
                                color: darkFontGrey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: GridView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: data.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 8, // space bettwen to and bottom
                          crossAxisSpacing: 8, // space bettwen left and rghit
                          mainAxisExtent: 300, //  height of one contaner

                          crossAxisCount: 2, // numper of column
                        ),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              controller.chekifva(data[index]);
                              Get.to(ItemDetails(
                                title: '${data[index]['p_name']}',
                                data: data[index],
                              ));
                            },
                            child: Card(
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 4),
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    color: whiteColor,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      '${data[index]['p_imgs'][0]}',
                                      width: 200,
                                      height: 150,
                                      fit: BoxFit.cover,
                                    ),
                                    Text(
                                      '${data[index]['p_name']}',
                                      style: TextStyle(
                                          color: darkFontGrey,
                                          fontFamily: semibold),
                                    ),
                                    Text(
                                      '${data[index]['p_price']}'.numCurrency,
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: redColor,
                                          fontFamily: bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
