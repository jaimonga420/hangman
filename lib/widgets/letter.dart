import 'package:flutter/material.dart';

import '../ui/colors.dart' as color;

Widget letter(String character, bool isVisible) {
  return Container(
    height: 65,
    width: 50,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
        color: color.AppColor.primaryColorDark,
        borderRadius: BorderRadius.circular(4)),
    child: Visibility(
        visible: isVisible,
        child: Text(
          character,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 40),
        )),
  );
}
