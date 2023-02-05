import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:movies_app/globals/common_widgets/app_show_image.dart';
import 'package:movies_app/globals/common_widgets/custom_image.dart';
import 'package:movies_app/globals/constants/api_urls.dart';
import 'package:movies_app/controllers/movie_detail_controller.dart';
import 'package:movies_app/globals/extensions/localization_extension.dart';
import 'package:movies_app/theme/app_colors.dart';
import 'package:movies_app/theme/app_dimentions.dart';
import 'package:movies_app/globals/common_widgets/circular_loader.dart';
import 'package:movies_app/globals/common_widgets/custom_appbar.dart';
import 'package:movies_app/globals/common_widgets/no_content_information_card.dart';
import 'package:sizer/sizer.dart';
import '../globals/localizations/localization_keys.dart';

class MovieDetailPage extends StatelessWidget {
  MovieDetailPage({super.key, required this.movieId}) {
    movieDetailController.getMovieDetail(movieId);
  }
  final movieDetailController = Get.put(MovieDetailController());
  final int movieId;
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: CustomAppbar(
            title: movieDetailController.loading.value ||
                    movieDetailController.movieDetail.value.id == null
                ? LocalizationKeys.filmDetail.translate
                : movieDetailController.movieDetail.value.title!,
            backFunction: () {
              Get.back();
            },
          ),
          body: pageBody(),
        ));
  }

  Widget pageBody() {
    return Padding(
      padding: AppDimens.generalAppPadding,
      child: movieDetailController.loading.value
          ? const CircularLoader()
          : movieDetailController.movieDetail.value.id == null
              ? NoContentInformationCard(
                  text: LocalizationKeys.noFilmDetail.translate)
              : detailView(),
    );
  }

  Column detailView() {
    return Column(
      children: [
        Expanded(
          flex: 5,
          child: Stack(
            children: [
              CustomImage(
                  imageNetworkUrl:
                      movieDetailController.movieDetail.value.posterPath == null
                          ? ""
                          : AppConstants.imageBaseUrl +
                              movieDetailController
                                  .movieDetail.value.posterPath!),
              Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        color: Colors.white30, shape: BoxShape.circle),
                    child: Text(
                      movieDetailController.movieDetail.value.voteAverage
                          .toString(),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ))
            ],
          ),
        ),
        SizedBox(height: 2.h),
        Expanded(
          flex: 4,
          child: ListView(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      if (movieDetailController
                              .movieDetail.value.backdropPath !=
                          null) {
                        await showDialog(
                            context: Get.context!,
                            builder: (_) => ShowImage(
                                path: AppConstants.imageBaseUrl +
                                    movieDetailController
                                        .movieDetail.value.backdropPath!));
                      }
                    },
                    child: SizedBox(
                      width: 25.w,
                      height: 15.h,
                      child: CustomImage(
                          imageNetworkUrl: movieDetailController
                                      .movieDetail.value.backdropPath ==
                                  null
                              ? ""
                              : AppConstants.imageBaseUrl +
                                  movieDetailController
                                      .movieDetail.value.backdropPath!),
                    ),
                  ),
                  SizedBox(width: 1.w),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movieDetailController.movieDetail.value.originalTitle
                              .toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.w),
                              child: Text(movieDetailController
                                  .movieDetail.value.voteAverage
                                  .toString()),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.w),
                              child: Text(
                                  "(${movieDetailController.movieDetail.value.voteCount} ${LocalizationKeys.evaluation.translate})"),
                            )
                          ],
                        ),
                        if (movieDetailController.movieDetail.value.genres !=
                            null)
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 1.h),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(
                                  movieDetailController
                                      .movieDetail.value.genres!.length,
                                  (index) => Container(
                                    margin: const EdgeInsets.all(2),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 1.h, horizontal: 2.w),
                                    decoration: const BoxDecoration(
                                      color: AppColors.secondaryAppColor,
                                      borderRadius: BorderRadius.all(
                                          AppDimens.smallRadius),
                                    ),
                                    child: Text(
                                      movieDetailController.movieDetail.value
                                          .genres![index].name,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 1.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  miniInfo(
                      LocalizationKeys.releaseDate.translate,
                      DateFormat("dd.MM.yyyy").format(movieDetailController
                          .movieDetail.value.releaseDate!)),
                  miniInfo(
                      LocalizationKeys.originalLanguage.translate,
                      movieDetailController.movieDetail.value.originalLanguage
                          .toString()),
                  miniInfo(
                      LocalizationKeys.popularity.translate,
                      movieDetailController.movieDetail.value.popularity
                          .toString()),
                ],
              ),
              if (movieDetailController.movieDetail.value.overview != null)
                Text(
                  movieDetailController.movieDetail.value.overview!,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.normal),
                ),
            ],
          ),
        )
      ],
    );
  }

  Column miniInfo(String title, String value) {
    return Column(
      children: [
        Text(title),
        Text(
          value,
          style: TextStyle(
              color: Colors.black,
              fontSize: 11.sp,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
