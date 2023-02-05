import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/globals/utils/localization_util.dart';
import 'package:movies_app/views/category_page.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => GetMaterialApp(
        title: 'Movies',
        translations: LocalizationUtil(),
        fallbackLocale: LocalizationUtil.fallbackLocale,
        locale: LocalizationUtil.defaultLocale(),
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.rightToLeftWithFade,
        home: CategoryPage(),
        themeMode: ThemeMode.system,
      ),
    );
  }
}
