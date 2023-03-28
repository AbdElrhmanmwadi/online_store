// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/chatcontroller.dart';
import 'package:emart_app/siervses/fierstor_servises.dart';
import 'package:emart_app/views/home_screen/Account_screen/addProduct.dart';
import 'package:emart_app/widgets/sendermessage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatContoller());
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
          elevation: 1,
          title: Text(
            '${controller.friendName}',
            style: TextStyle(fontFamily: semibold, color: whiteColor),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Obx(
                () => controller.isLoding.value
                    ? Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(redColor),
                        ),
                      )
                    : Expanded(
                        child: StreamBuilder(
                          stream: fierStorServices
                              .getCatMessage(controller.chatDocId.toString()),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(redColor),
                                ),
                              );
                            } else if (snapshot.data!.docs.isEmpty) {
                              return Center(
                                child: Text(
                                  'Send a message...',
                                  style: TextStyle(color: darkFontGrey),
                                ),
                              );
                            } else {
                              return ListView(
                                children: snapshot.data!.docs
                                    .mapIndexed((currentValue, index) {
                                  var data = snapshot.data!.docs[index];
                                  return Align(
                                    alignment: data['uid'] == currerntuser!.uid
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    child: sendermessage(
                                      data: data,
                                    ),
                                  );
                                }).toList(),
                              );
                            }
                          },
                        ),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                      controller: controller.msgController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: textfieldGrey)),
                          hintText: 'Type a message...'),
                    )),
                    IconButton(
                      onPressed: () {
                        controller.sendMsg(controller.msgController.text);
                        controller.msgController.clear();
                      },
                      icon: Icon(Icons.send),
                      color: redColor,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
