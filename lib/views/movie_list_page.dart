import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/globals/common_widgets/app_smart_refresher_footer.dart';
import 'package:movies_app/globals/common_widgets/custom_image.dart';
import 'package:movies_app/globals/common_widgets/no_content_information_card.dart';
import 'package:movies_app/globals/constants/api_urls.dart';
import 'package:movies_app/controllers/movie_list_controller.dart';
import 'package:movies_app/globals/extensions/localization_extension.dart';
import 'package:movies_app/models/movie_model.dart';
import 'package:movies_app/theme/app_colors.dart';
import 'package:movies_app/theme/app_dimentions.dart';
import 'package:movies_app/globals/common_widgets/circular_loader.dart';
import 'package:movies_app/globals/common_widgets/custom_appbar.dart';
import 'package:movies_app/theme/app_text_styles.dart';
import 'package:movies_app/views/category_page.dart';
import 'package:movies_app/views/movie_detail_page.dart';
import 'package:movies_app/views/search_movie_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../globals/localizations/localization_keys.dart';

class MovieListPage extends StatelessWidget {
  MovieListPage({super.key, required this.categoryId}) {
    movieListController.getMovieList();
    movieListController.categoryId = categoryId;
  }
  final movieListController = Get.put(MovieListController());
  final int categoryId;
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: LocalizationKeys.films.translate,
        backFunction: () {
          Get.offAll(CategoryPage());
        },
        actions: IconButton(
            onPressed: () {
              Get.to(() => SearchMoviePage());
            },
            icon: const Icon(Icons.search)),
      ),
      body: pageBody(),
    );
  }

  Widget pageBody() {
    return Padding(
        padding: AppDimens.generalAppPadding,
        child: Obx(() => movieListController.pageLoading.value
            ? const CircularLoader()
            : movieListController.movieList.isEmpty
                ? NoContentInformationCard(
                    text: LocalizationKeys.noFilmsInThisCategory.translate)
                : SizedBox(
                    width: Get.width,
                    height: Get.height,
                    child: SmartRefresher(
                        footer: const SmartRefresherFooterWidget(),
                        enablePullUp: true,
                        controller: refreshController,
                        onRefresh: () =>
                            movieListController.onRefresh(refreshController),
                        onLoading: () =>
                            movieListController.onLoading(refreshController),
                        child: movieList()))));
  }

  GridView movieList() {
    return GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        children:
            List.generate(movieListController.movieList.length, (int index) {
          MovieListModel movie = movieListController.movieList[index];
          return GestureDetector(
              onTap: () {
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
                            child: Text(movie.favoriteCount.toString()),
                          ))
                    ])),
                Expanded(
                    child: Text(
                  movie.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyTextStyle,
                ))
              ]));
        }));
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
