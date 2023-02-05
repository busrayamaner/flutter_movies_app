import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/globals/common_widgets/custom_image.dart';
import 'package:movies_app/theme/app_colors.dart';

class ShowImage extends StatelessWidget {
  const ShowImage({super.key, required this.path});
  final String path;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(''),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close_rounded),
                  color: AppColors.primaryAppColor,
                ),
              ],
            ),
          ),
          SizedBox(
              width: Get.width,
              height: Get.height * 0.6,
              child: CustomImage(imageNetworkUrl: path)),
        ],
      ),
    );
  }
}
