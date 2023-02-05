import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:movies_app/globals/common_widgets/no_content_information_card.dart';
import 'package:movies_app/controllers/category_controller.dart';
import 'package:movies_app/globals/constants/api_urls.dart';
import 'package:movies_app/globals/extensions/localization_extension.dart';
import 'package:movies_app/globals/localizations/localization_keys.dart';
import 'package:movies_app/theme/app_dimentions.dart';
import 'package:movies_app/globals/common_widgets/circular_loader.dart';
import 'package:movies_app/views/movie_list_page.dart';
import 'package:sizer/sizer.dart';
import '../globals/common_widgets/custom_appbar.dart';

class CategoryPage extends StatelessWidget {
  CategoryPage({super.key}) {
    categoryController.getCategoryList();
  }
  final categoryController = Get.put(CategoryController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: LocalizationKeys.categories.translate,
        hasCategoryIcon: false,
        actions: selectLanguage(),
      ),
      body: pageBody(),
    );
  }

  Widget pageBody() {
    return Padding(
      padding: AppDimens.generalAppPadding,
      child: Obx(() => categoryController.loading.value
          ? const CircularLoader()
          : categoryController.categoryList.value.genres.isEmpty
              ? NoContentInformationCard(
                  text: LocalizationKeys.noCategories.translate)
              : categoryView()),
    );
  }

  Widget categoryView() {
    int columnCount = 4;
    return AnimationLimiter(
      child: GridView.count(
        crossAxisCount: columnCount,
        children: List.generate(
          categoryController.categoryList.value.genres.length,
          (int index) {
            return AnimationConfiguration.staggeredGrid(
              position: index,
              duration: const Duration(milliseconds: 750),
              columnCount: columnCount,
              child: ScaleAnimation(
                child: FadeInAnimation(
                  child: GestureDetector(
                    onTap: () {
                      Get.to(MovieListPage(
                          categoryId: categoryController
                              .categoryList.value.genres[index].id));
                    },
                    child: Container(
                      padding: EdgeInsets.all(4.sp),
                      margin: EdgeInsets.all(5.sp),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.sp),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade400,
                            offset: const Offset(0, 2),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: Text(
                        categoryController
                            .categoryList.value.genres[index].name,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 9.5.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  PopupMenuButton<int> selectLanguage() {
    return PopupMenuButton<int>(
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: Row(
            children: [
              Icon(
                AppConstants.langCode == "tr-TR"
                    ? Icons.star
                    : (Icons.star_border),
              ),
              const SizedBox(width: 10),
              Text(LocalizationKeys.turkish.translate)
            ],
          ),
        ),
        PopupMenuItem(
          value: 2,
          child: Row(
            children: [
              Icon(
                AppConstants.langCode == "en-US"
                    ? Icons.star
                    : (Icons.star_border),
              ),
              const SizedBox(width: 10),
              Text(LocalizationKeys.english.translate)
            ],
          ),
        ),
      ],
      offset: const Offset(0, 100),
      color: Colors.grey,
      elevation: 2,
      onSelected: (value) {
        if (value == 1) {
          Get.updateLocale(const Locale('tr', 'TR'));
          AppConstants.langCode = "tr-TR";
        } else if (value == 2) {
          Get.updateLocale(const Locale('en', 'us'));
          AppConstants.langCode = "en-US";
        }
        categoryController.getCategoryList();
      },
    );
  }
}
