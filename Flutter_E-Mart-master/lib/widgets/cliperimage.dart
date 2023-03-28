import 'package:flutter/material.dart';

class ImageClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = Path();
    p.lineTo(0, size.height);
    p.quadraticBezierTo(1 * size.width / 4, size.height, size.width - 10,
        4.6 * size.height / 5);

    p.lineTo(size.width, 0);
    p.close();

    return p;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
