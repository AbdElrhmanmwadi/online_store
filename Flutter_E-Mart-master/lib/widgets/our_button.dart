import 'package:emart_app/consts/colors.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/views/home_screen/Account_screen/addProduct.dart';
import 'package:flutter/material.dart';

class ourbutton extends StatelessWidget {
  final color, title, onpressed;
  const ourbutton({
    Key? key,
    required this.color,
    required this.title,
    required this.onpressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, 20),
            padding: EdgeInsets.all(12),
            backgroundColor: color),
        onPressed: onpressed,
        child: Text(
          title,
          style: TextStyle(fontFamily: bold, color: Colors.white),
        ));
  }
}
