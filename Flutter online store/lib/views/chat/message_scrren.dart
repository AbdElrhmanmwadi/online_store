// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/siervses/fierstor_servises.dart';
import 'package:emart_app/views/chat/chat_screen.dart';
import 'package:emart_app/views/home_screen/Account_screen/addProduct.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class messageScreen extends StatelessWidget {
  const messageScreen({super.key});

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
            color: whiteColor,
          ),
          elevation: 0,
          title: Text(
            'My messages',
            style: TextStyle(color: whiteColor, fontFamily: semibold),
          ),
        ),
        body: StreamBuilder(
          stream: fierStorServices.getAllMessage(),
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
                  'No messages yet!',
                  style: TextStyle(color: darkFontGrey),
                ),
              );
            } else {
              var data = snapshot.data!.docs;
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          elevation: 0,
                          child: ListTile(
                            onTap: () {
                              Get.to(ChatScreen(), arguments: [
                                data[index]['friend_name'],
                                data[index]['toId']
                              ]);
                            },
                            leading: CircleAvatar(
                              backgroundColor: redColor,
                              child: Icon(Icons.person),
                            ),
                            title: Text(
                              '${data[index]['friend_name']}',
                              style: TextStyle(
                                  fontFamily: semibold, color: darkFontGrey),
                            ),
                            subtitle: Text(
                              '${data[index]['last_msg']}',
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
