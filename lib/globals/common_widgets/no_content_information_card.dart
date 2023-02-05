import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';
import 'package:movies_app/theme/app_colors.dart';
import 'package:sizer/sizer.dart';

class NoContentInformationCard extends StatelessWidget {
  final String text;

  const NoContentInformationCard({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height,
      // padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h, bottom: 10.h),
      child: Card(
        child: ListView(
          children: [
            SizedBox(height: 5.h),
            Lottie.network(
                'https://assets5.lottiefiles.com/packages/lf20_zadfo6lc.json',
                width: Get.width / 2),
            SizedBox(height: 5.h),
            Padding(
              padding: EdgeInsets.all(5.w),
              child: Text(
                text,
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
