import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/models/search_movie_model.dart';
import 'package:movies_app/services/app_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SearchMovieListController extends GetxController {
  @override
  void onInit() {
    focusNode.value.requestFocus();
    super.onInit();
  }

  RxBool pageLoading = false.obs;
  RxBool listLoading = false.obs;
  RxInt pageIndex = 1.obs;
  int totalPage = 0;
  final Rx<FocusNode> focusNode = FocusNode().obs;
  TextEditingController searchController = TextEditingController();
  AppServices appServices = AppServices();
  RxList<Result> searchMovieList = <Result>[].obs;

  getSearchMovieList() async {
    try {
      setLoading();
      if (totalPage != 0 && totalPage < pageIndex.value) {
        return false;
      } else {
        SearchMovieModel movieModel =
            await appServices.searchdMovieList(searchController.text);
        if (pageIndex.value == 1) {
          totalPage = movieModel.totalPages;
        }
        searchMovieList.addAll(movieModel.results);
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
      searchMovieList.clear();
      bool result = await getSearchMovieList();
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
    result = await getSearchMovieList();

    if (result) {
      refreshController.loadComplete();
    } else {
      refreshController.loadFailed();
    }
  }
}
