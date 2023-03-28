// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/siervses/fierstor_servises.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

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
            'My Wishlist',
            style: TextStyle(color: darkFontGrey, fontFamily: semibold),
          ),
        ),
        body: StreamBuilder(
          stream: fierStorServices.getAllWishList(),
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
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: Image.network(
                            '${data[index]['p_imgs'][0]}',
                            width: 120,
                            fit: BoxFit.cover,
                          ),
                          title: Text(
                            '${data[index]['p_name']} ',
                            style:
                                TextStyle(fontFamily: semibold, fontSize: 16),
                          ),
                          subtitle: Text(
                            '${data[index]['p_price']}'.numCurrency,
                            style: TextStyle(
                                fontFamily: semibold, color: redColor),
                          ),
                          trailing: IconButton(
                              onPressed: () async {
                                // get id of doc
                                await firestore
                                    .collection(productCollection)
                                    .doc(data[index].id)
                                    .set({
                                  'p_wishlist': FieldValue.arrayRemove(
                                      [currerntuser!.uid])
                                }, SetOptions(merge: true));
                              },
                              icon: Icon(
                                Icons.favorite,
                                color: redColor,
                              )),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
