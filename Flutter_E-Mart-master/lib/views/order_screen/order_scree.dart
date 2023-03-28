// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/siervses/fierstor_servises.dart';
import 'package:emart_app/views/order_screen/order_detales.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrerersScreen extends StatelessWidget {
  const OrerersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white70, Colors.white, Colors.white],
          stops: [0.2, 0.5, 0.9],
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Colors.black,
          ),
          elevation: 0,
          title: Text(
            'My Oreders',
            style: TextStyle(color: darkFontGrey, fontFamily: semibold),
          ),
        ),
        body: StreamBuilder(
          stream: fierStorServices.getAllOrders(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              // ignore: prefer_const_constructors
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                ),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text(
                  'No oreders yet!',
                  style: TextStyle(color: darkFontGrey),
                ),
              );
            } else {
              var data = snapshot.data!.docs;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    // selectedColor: lightGrey,
                    // onTap: () {},
                    // selected: true,
                    leading: Text(
                      '${index + 1}',
                      style: TextStyle(
                        fontFamily: bold,
                        color: darkFontGrey,
                      ),
                    ),
                    title: Text(
                      '${data[index]['order_code']}',
                      style: TextStyle(color: redColor, fontFamily: semibold),
                    ),
                    subtitle: Text(
                      '${data[index]['total_amount']}'.numCurrency,
                      style: TextStyle(color: redColor, fontFamily: bold),
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          Get.to(() => OrdersDetails(
                                data: data[index],
                              ));
                        },
                        icon: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: darkFontGrey,
                        )),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

              // order_by
              // "wk0LKGQB5BhIOCJvmF51OzRmXSP2"
              // order_by_address
              // "12312"
              // order_by_city
              // "12312"
              // order_by_email
              // "121244245@gmail.com"
              // order_by_name
              // "123123"
              // order_by_phone
              // "123123"
              // order_by_postalcode
              // "123123"
              // order_by_state
              // "1231"
              // order_code
              // "233981237"
              // order_confirmed
              // false
              // order_date
              // February 28, 2023 at 8:29:45 PM UTC+2
              // order_delivered
              // false
              // order_on_delivered
              // false
              // order_placed
              // true
              // orders
              // 0
              // color
              // 4294198070
              // img
              // "https://th.bing.com/th/id/OIP.5eezsuLgrFtI4LTZBPJbVgHaLy?pid=ImgDet&rs=1"
              // quantity
              // 0
              // title
              // "Women Dresses"
              // tprice
              // 0
              // vendor_id
              // "hGBGJcfBr5f7MKe2pAgaBtWz2o03"
              // 1
              // color
              // 4282456960
              // img
              // "https://th.bing.com/th/id/OIP.5eezsuLgrFtI4LTZBPJbVgHaLy?pid=ImgDet&rs=1"
              // quantity
              // 1
              // title
              // "Women Dresses"
              // (string)
              // tprice
              // 1500
              // vendor_id
              // "hGBGJcfBr5f7MKe2pAgaBtWz2o03"
              // payment_method
              // "paypal"
              // shipping_method
              // "Home Delivery"
              // total_amount
              // 1500

              // Database location: nam5