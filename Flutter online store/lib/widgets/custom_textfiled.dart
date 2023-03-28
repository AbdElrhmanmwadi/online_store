import 'package:emart_app/consts/colors.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:flutter/material.dart';

class custom_textfield extends StatelessWidget {
  final name_filed, hinttext, controller, validator, keyboardType;
  const custom_textfield({
    Key? key,
    required this.name_filed,
    required this.hinttext,
    this.controller,
    this.validator,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name_filed,
          style: TextStyle(color: Colors.red, fontFamily: bold),
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          keyboardType: keyboardType,
          validator: validator,
          controller: controller,
          // ignore: prefer_const_constructors
          decoration: InputDecoration(
              hintText: hinttext,
              fillColor: lightGrey,
              filled: true,
              border: InputBorder.none,
              focusedBorder:
                  OutlineInputBorder(borderSide: BorderSide(color: redColor)),
              hintStyle: TextStyle(fontFamily: semibold, color: fontGrey)),
        )
      ],
    );
  }
}
