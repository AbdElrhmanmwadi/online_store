import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/cart_screen/shippingscereen.dart';

import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/Cart_controller.dart';
import 'package:emart_app/siervses/fierstor_servises.dart';
import 'package:emart_app/widgets/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class cart_screen extends StatefulWidget {
  const cart_screen({super.key});

  @override
  State<cart_screen> createState() => _cart_screenState();
}

class _cart_screenState extends State<cart_screen> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Container(
      // ignore: prefer_const_constructors
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white70, Colors.white, Colors.white],
          stops: [0.2, 0.5, 0.9],
        ),
      ),
      child: Scaffold(
        bottomNavigationBar: ourbutton(
            color: redColor,
            title: 'Procced to shipping',
            onpressed: () {
              Get.to(() => ShippingDeatils());
            }),
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          // ignore: prefer_const_constructors
          title: Text(
            'Shooping cart',
            style: TextStyle(color: darkFontGrey, fontFamily: semibold),
          ),
        ),
        body: StreamBuilder(
          stream: fierStorServices.getcart(currerntuser!.uid),
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
                  'Cart is empty!',
                  style: TextStyle(color: darkFontGrey),
                ),
              );
            } else {
              var data = snapshot.data!.docs;
              controller.calculate(data);
              controller.productSnapshot = data;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                        child: Container(
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            leading: Image.network(
                              '${data[index]['img']}',
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                            title: Text(
                              '${data[index]['title']} (x${data[index]['quantity']})',
                              style:
                                  TextStyle(fontFamily: semibold, fontSize: 16),
                            ),
                            subtitle: Text(
                              '${data[index]['tprice']}'.numCurrency,
                              style: TextStyle(
                                  fontFamily: semibold, color: redColor),
                            ),
                            trailing: IconButton(
                                onPressed: () {
                                  // get id of doc
                                  fierStorServices.DeleateDocument(
                                      data[index].id);
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: redColor,
                                )),
                          );
                        },
                      ),
                    )),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        color: Color.fromARGB(255, 236, 220, 188),
                        padding: EdgeInsets.all(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Totle price',
                              style: TextStyle(
                                  fontFamily: semibold, color: darkFontGrey),
                            ),
                            Obx(
                              () => Text(
                                '${controller.totaIp.value}'.numCurrency,
                                style: TextStyle(
                                    fontFamily: semibold, color: redColor),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
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
