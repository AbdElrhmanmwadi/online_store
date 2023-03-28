import 'package:emart_app/consts/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class featuredButton extends StatelessWidget {
  final title, icon;
  const featuredButton({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: EdgeInsets.symmetric(horizontal: 4),
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Color.fromARGB(255, 141, 138, 138), //New
              blurRadius: 5.0,
              offset: Offset(5, 5))
        ],
        borderRadius: BorderRadius.circular(10),
        color: whiteColor,
      ),
      child: Row(
        children: [
          Image.asset(
            icon,
            width: 60,
            fit: BoxFit.cover,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: TextStyle(fontFamily: semibold, color: darkFontGrey),
          ),
        ],
      ),
    );
  }
}
