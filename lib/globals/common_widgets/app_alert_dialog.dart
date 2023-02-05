import 'package:flutter/material.dart';
import 'package:movies_app/theme/app_colors.dart';
import 'package:sizer/sizer.dart';

class AppAlertDialog extends StatelessWidget {
  final String? alertDialogTitle;
  final String alertDialogContent;
  final String okButtonText;
  final String? cancelButtonText;
  final VoidCallback okButtonOnPressed;
  final VoidCallback? cancelButtonOnPressed;

  const AppAlertDialog({
    Key? key,
    this.alertDialogTitle,
    required this.alertDialogContent,
    required this.okButtonText,
    this.cancelButtonText,
    required this.okButtonOnPressed,
    this.cancelButtonOnPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      titlePadding: EdgeInsets.only(
        left: 7.w,
        top: 2.h,
        right: 7.w,
      ),
      contentPadding: EdgeInsets.only(
        left: 7.w,
        top: 4.h,
        right: 7.w,
        bottom: 4.h,
      ),
      title: alertDialogTitle != null
          ? Text(
              alertDialogTitle!,
              style: TextStyle(
                color: AppColors.primaryAppColor,
                fontSize: 25.sp,
                fontWeight: FontWeight.w500,
              ),
            )
          : null,
      content: Text(
        alertDialogContent,
        textAlign: TextAlign.left,
        style: TextStyle(
          color: AppColors.primaryText,
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
      actions: [
        cancelButtonText != null
            ? TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.secondaryText,
                  backgroundColor: Colors.white,
                  textStyle: TextStyle(fontSize: 12.sp),
                ),
                onPressed: cancelButtonOnPressed,
                child: Text(
                  cancelButtonText!,
                ),
              )
            : const SizedBox(),
        Container(
          margin: EdgeInsets.only(right: 4.w, left: 1.w),
          child: TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: AppColors.primaryAppColor,
              textStyle: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            onPressed: okButtonOnPressed,
            child: Text(
              okButtonText,
            ),
          ),
        ),
      ],
    );
  }

  Widget imageDialog(text, path, context) {
    return Dialog(
      // backgroundColor: Colors.transparent,
      // elevation: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$text',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close_rounded),
                  color: Colors.redAccent,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 220,
            height: 200,
            child: Image.network(
              '$path',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
