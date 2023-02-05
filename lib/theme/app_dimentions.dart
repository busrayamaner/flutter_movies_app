import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AppDimens {
  static final double contentHorizontalPadding = 2.w;
  static final double contentVerticalPadding = 1.h;

  static final EdgeInsetsGeometry generalAppPadding = EdgeInsets.symmetric(
      horizontal: AppDimens.contentHorizontalPadding,
      vertical: AppDimens.contentVerticalPadding);

  static const BorderRadius containerBorderRadius =
      BorderRadius.all(Radius.circular(10));

  static const Radius largeRadius = Radius.circular(30);
  static const Radius mediumRadius = Radius.circular(20);
  static const Radius smallRadius = Radius.circular(10);

  static const double userProfileImageRadius = 110;
}
