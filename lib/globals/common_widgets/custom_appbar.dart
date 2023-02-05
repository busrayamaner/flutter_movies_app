import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/views/category_page.dart';
import 'package:sizer/sizer.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar(
      {Key? key,
      required this.title,
      this.backFunction,
      this.actions,
      this.hasCategoryIcon = true})
      : super(key: key);

  final String title;
  final bool hasCategoryIcon;
  final Function()? backFunction;
  final Widget? actions;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: backFunction != null
          ? IconButton(
              onPressed: backFunction,
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 27,
              ),
            )
          : null,
      elevation: 0,
      centerTitle: true,
      actions: [
        if (actions != null) actions!,
        if (hasCategoryIcon)
          IconButton(
              onPressed: () {
                Get.offAll(CategoryPage());
              },
              icon: const Icon(Icons.category))
      ],
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      title: Text(
        title,
        style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w700),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(6.5.h);
}
