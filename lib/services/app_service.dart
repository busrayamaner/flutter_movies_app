import 'dart:convert';

import 'package:http/http.dart';
import 'package:movies_app/globals/constants/api_urls.dart';
import 'package:movies_app/models/category_model.dart';
import 'package:movies_app/models/movie_model.dart';
import 'package:movies_app/models/search_movie_model.dart';
import '../models/movie_detail_model.dart';
import 'base_service_requests.dart';

class AppServices {
  Future<CategoryModel> getCategoryList() async {
    Response? response = await BaseServiceRequests.getRequest(
        "${AppConstants.baseUrl}genre/movie/list?api_key=${AppConstants.apiKey}&language=${AppConstants.langCode}");
    if (response != null) {
      Map<String, dynamic> values = json.decode(response.body);
      if (response.statusCode == 200) {
        CategoryModel categoryList = CategoryModel.fromJson(values);
        return categoryList;
      } else {
        throw Exception(values["status_message"]);
      }
    }
    throw Exception("Beklenmeyen durum");
  }

  Future<MovieModel> getMovieList(int page, int categoryId) async {
    Response? response = await BaseServiceRequests.getRequest(
        "${AppConstants.movileListUrl}$categoryId/lists?api_key=${AppConstants.apiKey}&language=${AppConstants.langCode}");
    if (response != null) {
      Map<String, dynamic> values = json.decode(response.body);
      if (response.statusCode == 200) {
        MovieModel categoryList = MovieModel.fromJson(values);
        return categoryList;
      } else {
        return MovieModel(
            id: 0, page: 0, movies: [], totalPages: 0, totalResults: 0);
        //throw Exception(values["status_message"]);
      }
    }
    throw Exception("Beklenmeyen durum");
  }

  Future<MovieDetailModel> getMovieDetail(int movieId) async {
    Response? response = await BaseServiceRequests.getRequest(
        "${AppConstants.movileListUrl}$movieId?api_key=${AppConstants.apiKey}&language=${AppConstants.langCode}");
    if (response != null) {
      Map<String, dynamic> values = json.decode(response.body);
      if (response.statusCode == 200) {
        MovieDetailModel categoryList = MovieDetailModel.fromJson(values);
        return categoryList;
      } else {
        return MovieDetailModel();
        // throw Exception(values["status_message"]);
      }
    }
    throw Exception("Beklenmeyen durum");
  }

  Future<SearchMovieModel> searchdMovieList(String query) async {
    Response? response = await BaseServiceRequests.getRequest(
        "${AppConstants.searchMovileListUrl}movie?api_key=${AppConstants.apiKey}&language=${AppConstants.langCode}&query=$query");
    if (response != null) {
      Map<String, dynamic> values = json.decode(response.body);
      if (response.statusCode == 200) {
        SearchMovieModel categoryList = SearchMovieModel.fromJson(values);
        return categoryList;
      } else {
        throw Exception(values["status_message"]);
      }
    }
    throw Exception("Beklenmeyen durum");
  }
}
