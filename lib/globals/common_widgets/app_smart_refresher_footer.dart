import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/globals/extensions/localization_extension.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../theme/app_colors.dart';
import '../localizations/localization_keys.dart';

class SmartRefresherFooterWidget extends StatelessWidget {
  const SmartRefresherFooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomFooter(
      builder: (BuildContext context, LoadStatus? mode) {
        Widget statosWidget;
        if (mode == LoadStatus.idle) {
          statosWidget =
              statusInfoMMessage(LocalizationKeys.pullToLoadMore.translate);
        } else if (mode == LoadStatus.loading) {
          statosWidget = const Center(
              child:
                  CircularProgressIndicator(color: AppColors.primaryAppColor));
        } else if (mode == LoadStatus.failed) {
          statosWidget =
              statusInfoMMessage(LocalizationKeys.noMoreFilm.translate);
        } else if (mode == LoadStatus.canLoading) {
          statosWidget =
              statusInfoMMessage(LocalizationKeys.pullToLoadMore.translate);
        } else {
          statosWidget =
              statusInfoMMessage(LocalizationKeys.noMoreFilm.translate);
        }
        return statosWidget;
      },
    );
  }

  SizedBox statusInfoMMessage(String title) {
    return SizedBox(
        width: Get.width,
        height: 80,
        child: Shimmer.fromColors(
            baseColor: AppColors.primaryAppColor,
            highlightColor: AppColors.secondaryAppColor,
            child: Text(title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ))));
  }
}
