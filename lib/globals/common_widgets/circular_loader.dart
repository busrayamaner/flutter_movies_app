import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class CircularLoader extends StatelessWidget {
  const CircularLoader({Key? key, this.color}) : super(key: key);
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.network(
          'https://assets3.lottiefiles.com/packages/lf20_qjosmr4w.json',
          width: Get.width / 2),
    );
  }
}
