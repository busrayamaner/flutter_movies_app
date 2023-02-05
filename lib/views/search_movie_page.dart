import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/globals/common_widgets/app_alert_dialog.dart';
import 'package:movies_app/globals/common_widgets/custom_image.dart';
import 'package:movies_app/globals/common_widgets/no_content_information_card.dart';
import 'package:movies_app/globals/constants/api_urls.dart';
import 'package:movies_app/controllers/search_movie_list_controller.dart';
import 'package:movies_app/globals/extensions/localization_extension.dart';
import 'package:movies_app/models/search_movie_model.dart';
import 'package:movies_app/theme/app_colors.dart';
import 'package:movies_app/theme/app_dimentions.dart';
import 'package:movies_app/globals/common_widgets/circular_loader.dart';
import 'package:movies_app/globals/common_widgets/custom_appbar.dart';
import 'package:movies_app/theme/app_text_styles.dart';
import 'package:movies_app/views/movie_detail_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';
import '../globals/common_widgets/app_smart_refresher_footer.dart';
import '../globals/localizations/localization_keys.dart';

class SearchMoviePage extends StatelessWidget {
  SearchMoviePage({super.key});
  final movieListController = Get.put(SearchMovieListController());
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: LocalizationKeys.searchFilm.translate,
        backFunction: () {
          Get.back();
        },
      ),
      body: pageBody(),
    );
  }

  Widget _searchTextField() {
    return Obx(() => TextField(
          controller: movieListController.searchController,
          focusNode: movieListController.focusNode.value,
          autofocus: false,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: AppColors.primaryAppColor,
              size: 22.sp,
            ),
            hintText: LocalizationKeys.search.translate,
            filled: true,
            fillColor: Colors.grey.shade200,
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(50)),
          ),
          onSubmitted: (String searchQuery) {
            if (searchQuery.length >= 2) {
              movieListController.getSearchMovieList();
            } else {
              showDialog(
                context: Get.context!,
                builder: (BuildContext alertContext) {
                  return AppAlertDialog(
                    alertDialogTitle: LocalizationKeys.warning.translate,
                    alertDialogContent:
                        LocalizationKeys.min2CharPlease.translate,
                    okButtonText: LocalizationKeys.okay.translate,
                    okButtonOnPressed: () {
                      Get.back();
                    },
                  );
                },
              );
            }
          },
        ));
  }

  Widget pageBody() {
    return Padding(
        padding: AppDimens.generalAppPadding,
        child: Obx(() => movieListController.pageLoading.value
            ? const CircularLoader()
            : movieListController.searchController.text == ""
                ? _searchTextField()
                : movieListController.searchMovieList.isEmpty
                    ? Stack(
                        children: [
                          NoContentInformationCard(
                              text: LocalizationKeys.noSearchedFilm.translate),
                          _searchTextField(),
                        ],
                      )
                    : Column(children: [
                        _searchTextField(),
                        SizedBox(height: 2.h),
                        Expanded(
                            child: SmartRefresher(
                                footer: const SmartRefresherFooterWidget(),
                                enablePullUp: true,
                                controller: refreshController,
                                onRefresh: () => movieListController
                                    .onRefresh(refreshController),
                                onLoading: () => movieListController
                                    .onLoading(refreshController),
                                child: movieListWidget()))
                      ])));
  }

  GridView movieListWidget() {
    return GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        children: List.generate(movieListController.searchMovieList.length,
            (int index) {
          Result movie = movieListController.searchMovieList[index];
          return GestureDetector(
              onTap: () {
                movieListController.focusNode.value.unfocus();
                Get.to(() => MovieDetailPage(movieId: movie.id));
              },
              child: Column(children: [
                Expanded(
                    flex: 2,
                    child: Stack(children: [
                      CustomImage(
                          imageNetworkUrl: movie.posterPath == null
                              ? ""
                              : AppConstants.imageBaseUrl + movie.posterPath!),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(movie.popularity.toString()),
                          ))
                    ])),
                Expanded(
                    child: Text(
                  movie.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyTextStyle,
                ))
              ]));
        }));
  }
}
