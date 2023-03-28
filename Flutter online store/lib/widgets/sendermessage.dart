import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/colors.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class sendermessage extends StatelessWidget {
  final DocumentSnapshot data;
  const sendermessage({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var t =
        data['created_on'] == null ? DateTime.now : data['created_on'].toDate();
    var time = intl.DateFormat("h:mma").format(t);
    return Directionality(
      textDirection: data['uid'] == currerntuser!.uid
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: data['uid'] == currerntuser!.uid ? redColor : darkFontGrey,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${data['msg']}',
              style: TextStyle(color: whiteColor, fontSize: 16),
            ),
            Text(
              '$time',
              style: TextStyle(
                color: whiteColor.withOpacity(.5),
              ),
            )
          ],
        ),
      ),
    );
  }
}
