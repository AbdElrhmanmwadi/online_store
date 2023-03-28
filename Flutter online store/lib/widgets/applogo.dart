import 'package:emart_app/consts/images.dart';
import 'package:flutter/material.dart';

class applogowidget extends StatelessWidget {
  const applogowidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 85,
      height: 85,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Image.asset(
          'assets/images/background2.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
