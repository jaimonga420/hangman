import 'package:flutter/material.dart';

Widget figure(bool isVisible, String path) {
  return Visibility(
      visible: isVisible,
      child: SizedBox(
        height: 250,
        width: 250,
        child: Image.asset(path),
      ));
}
