import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/theme/app_colors.dart';
import 'package:movies_app/theme/app_dimentions.dart';
import 'package:shimmer/shimmer.dart';

class CustomImage extends StatelessWidget {
  const CustomImage(
      {Key? key, required this.imageNetworkUrl, this.hasRadius = true})
      : super(key: key);

  final String imageNetworkUrl;
  final bool hasRadius;

  @override
  Widget build(BuildContext context) {
    return imageNetworkUrl == ""
        ? errorWidget()
        : CachedNetworkImage(
            imageUrl: imageNetworkUrl,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(hasRadius
                    ? AppDimens.smallRadius
                    : const Radius.circular(0)),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            progressIndicatorBuilder: (_, __, ___) => Shimmer.fromColors(
              baseColor: const Color.fromARGB(255, 204, 204, 204),
              highlightColor: AppColors.secondaryAppColor,
              period: const Duration(seconds: 1),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.shimmerChildBgColor,
                  borderRadius: const BorderRadius.all(AppDimens.smallRadius),
                ),
                height: 0,
              ),
            ),
            errorWidget: (_, __, ___) => errorWidget(),
          );
  }

  Container errorWidget() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.cachedImageErrorBg,
        borderRadius: BorderRadius.all(AppDimens.smallRadius),
      ),
      child: const Icon(
        Icons.error,
        color: AppColors.cachedImageErrorIcon,
      ),
    );
  }
}
