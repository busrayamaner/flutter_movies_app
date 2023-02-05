import 'package:get/get.dart';
import 'package:movies_app/services/app_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../models/movie_model.dart';

class MovieListController extends GetxController {
  RxBool pageLoading = false.obs;
  RxBool listLoading = false.obs;
  int categoryId = 0;
  RxInt pageIndex = 1.obs;
  int totalPage = 0;
  AppServices appServices = AppServices();

  RxList<MovieListModel> movieList = <MovieListModel>[].obs;

  getMovieList() async {
    try {
      setLoading();
      if (totalPage != 0 && totalPage < pageIndex.value) {
        return false;
      } else {
        MovieModel movieModel =
            await appServices.getMovieList(pageIndex.value, categoryId);
        if (pageIndex.value == 1) {
          totalPage = movieModel.totalPages;
        }
        movieList.addAll(movieModel.movies);
      }

      return true;
    } catch (e) {
      return false;
    } finally {
      setLoading();
    }
  }

  setLoading() {
    if (pageIndex.value == 1) {
      pageLoading.value = !pageLoading.value;
    } else {
      listLoading.value = !listLoading.value;
    }
  }

  void onRefresh(RefreshController refreshController) async {
    try {
      pageIndex.value = 1;
      movieList.clear();
      bool result = await getMovieList();
      if (result) {
        refreshController.refreshCompleted();
      }
    } catch (e) {
      refreshController.refreshFailed();
    }
  }

  void onLoading(RefreshController refreshController) async {
    bool result = false;
    pageIndex.value = pageIndex.value + 1;
    result = await getMovieList();

    if (result) {
      refreshController.loadComplete();
    } else {
      refreshController.loadFailed();
    }
  }
}
