import 'package:number_keyboard/utils/app_color.dart';
import 'package:flutter/material.dart';

class Reusable {
  static var boxShadow = BoxShadow(
    color: AppColor.greyPoint5,
    spreadRadius: 2,
    blurRadius: 4,
    offset: const Offset(0, 0), // changes position of shadow
  );
}
