import 'package:flutter/material.dart';
import 'package:study_app/configs/themes/app_colors.dart';
import 'package:study_app/configs/themes/ui_parameters.dart';
import 'package:get/get.dart';

TextStyle cartTitles(context) {
  return TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: UIParameters.isDarkMode()
        ? Theme.of(context).textTheme.bodyText1!.color
        : Theme.of(context).primaryColor,
  );
}

const questionTS = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w800,
);
const detailText = TextStyle(
  fontSize: 12,
);
const headerText = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.w700,
  color: onSurfaceTextColor,
);
const appBarTS = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 16,
  color: onSurfaceTextColor,
);
TextStyle countDownTimerTs() => TextStyle(
      letterSpacing: 2,
      color: UIParameters.isDarkMode()
          ? Theme.of(Get.context!).textTheme.bodyLarge!.color
          : Theme.of(Get.context!).primaryColor,
    );
