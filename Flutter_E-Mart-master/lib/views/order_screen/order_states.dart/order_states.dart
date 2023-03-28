import 'package:emart_app/consts/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrederStates extends StatelessWidget {
  final color, title, icon, showDone;
  const OrederStates(
      {super.key,
      required this.color,
      required this.title,
      required this.icon,
      required this.showDone});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
            border: Border.all(color: color),
            borderRadius: BorderRadius.circular(10)),
        child: Icon(
          icon,
          color: color,
        ),
      ),
      trailing: SizedBox(
        height: 100,
        width: 120,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(color: darkFontGrey),
            ),
            showDone
                ? Icon(
                    icon,
                    color: color,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
