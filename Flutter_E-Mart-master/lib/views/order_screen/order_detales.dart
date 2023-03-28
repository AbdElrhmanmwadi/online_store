// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/views/order_screen/order_states.dart/order_states.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class OrdersDetails extends StatelessWidget {
  final dynamic data;
  const OrdersDetails({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'Order Details',
            style: TextStyle(fontFamily: semibold, color: darkFontGrey),
          ),
          leading: BackButton(
            color: darkFontGrey,
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(4),
          child: SingleChildScrollView(
            child: Column(children: [
              OrederStates(
                  color: redColor,
                  title: 'placed',
                  icon: Icons.done,
                  showDone: data['order_placed']),
              OrederStates(
                  color: Colors.blueAccent,
                  title: 'Confirmed',
                  icon: Icons.thumb_up,
                  showDone: data['order_confirmed']),
              OrederStates(
                  color: Colors.yellow,
                  title: 'On Delivery',
                  icon: Icons.car_crash,
                  showDone: data['order_on_delivered']),
              OrederStates(
                  color: Colors.purple,
                  title: 'Delivered',
                  icon: Icons.done_all_outlined,
                  showDone: data['order_delivered']),
              Divider(),
              SizedBox(
                height: 10,
              ),
              Card(
                elevation: 10,
                child: Column(
                  children: [
                    Column(
                      children: [
                        orderPlaceDeatails(
                          d1: data['order_code'],
                          d2: data['shipping_method'],
                          title1: 'Oreder Code',
                          title2: 'Shipping Method ',
                        ),
                        orderPlaceDeatails(
                          d1: intl.DateFormat()
                              .add_yMd()
                              .format(data['order_date'].toDate()),
                          d2: data['payment_method'],
                          title1: 'Oreder Date',
                          title2: 'Payment Method ',
                        ),
                        orderPlaceDeatails(
                          d1: 'Unpaid',
                          d2: 'Order Placed',
                          title1: 'Payment Status',
                          title2: 'Delivery Status',
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Shipping Addres',
                                      style: TextStyle(
                                        fontFamily: semibold,
                                      ),
                                    ),
                                    Text(
                                      '${data['order_by_name']}',
                                      style: TextStyle(
                                        fontFamily: semibold,
                                      ),
                                    ),
                                    Text(
                                      '${data['order_by_email']}',
                                      style: TextStyle(
                                        fontFamily: semibold,
                                      ),
                                    ),
                                    Text(
                                      '${data['order_by_address']}',
                                      style: TextStyle(
                                        fontFamily: semibold,
                                      ),
                                    ),
                                    Text(
                                      '${data['order_by_city']}',
                                      style: TextStyle(
                                        fontFamily: semibold,
                                      ),
                                    ),
                                    Text(
                                      '${data['order_by_state']}',
                                      style: TextStyle(
                                        fontFamily: semibold,
                                      ),
                                    ),
                                    Text(
                                      '${data['order_by_phone']}',
                                      style: TextStyle(
                                        fontFamily: semibold,
                                      ),
                                    ),
                                    Text(
                                      '${data['order_by_postalcode']}',
                                      style: TextStyle(
                                        fontFamily: semibold,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 120,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Total Amount',
                                        style: TextStyle(
                                          fontFamily: semibold,
                                        ),
                                      ),
                                      Text(
                                        '${data['total_amount']}'.numCurrency,
                                        style: TextStyle(
                                            fontFamily: bold, color: redColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      ],
                    )
                  ],
                ),
              ),
              Divider(),
              SizedBox(
                height: 10,
              ),
              Text(
                'Ordered Product',
                style: TextStyle(
                  color: darkFontGrey,
                  fontFamily: semibold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                borderOnForeground: false,
                elevation: 10,
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: List.generate(data['orders'].length, (index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        orderPlaceDeatails(
                          title2: data['orders'][index]['tprice'],
                          d1: data['orders'][index]['quantity'],
                          d2: 'Refundable',
                          title1: data['orders'][index]['title'],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Container(
                            width: 30,
                            height: 20,
                            color: Color(data['orders'][index]['color']),
                          ),
                        ),
                        Divider()
                      ],
                    );
                  }).toList(),
                ),
              )
            ]),
          ),
        ));
  }
}

class orderPlaceDeatails extends StatelessWidget {
  const orderPlaceDeatails({
    Key? key,
    required this.title1,
    required this.title2,
    required this.d1,
    required this.d2,
  }) : super(key: key);

  final title1, title2, d1, d2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$title1',
                style: TextStyle(fontFamily: semibold, color: darkFontGrey),
              ),
              Text('$d1',
                  style: TextStyle(fontFamily: semibold, color: redColor)),
            ],
          ),
          SizedBox(
            width: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$title2',
                  style: TextStyle(fontFamily: semibold, color: darkFontGrey),
                ),
                Text('$d2', style: TextStyle(color: darkFontGrey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
