import 'package:emart_app/consts/colors.dart';
import 'package:emart_app/consts/styles.dart';
import 'package:flutter/material.dart';

class home_Button extends StatelessWidget {
  final image, width_image, title_image, width_contaner, height_contaner;

  const home_Button({
    Key? key,
    required this.image,
    required this.width_image,
    required this.title_image,
    this.width_contaner = 2.5,
    this.height_contaner = .12,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Container(
          height: MediaQuery.of(context).size.height * height_contaner,
          width: MediaQuery.of(context).size.width / height_contaner,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Color.fromARGB(255, 141, 138, 138), //New
                  blurRadius: 5.0,
                  offset: Offset(5, 5))
            ],
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                image,
                width: width_image,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                title_image,
                style: TextStyle(fontFamily: semibold, color: darkFontGrey),
              )
            ],
          ),
        ),
      ),
    );
  }
}
