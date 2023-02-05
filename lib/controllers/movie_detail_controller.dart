import 'package:get/get.dart';
import 'package:movies_app/models/movie_detail_model.dart';
import 'package:movies_app/services/app_service.dart';

class MovieDetailController extends GetxController {
  RxBool loading = false.obs;
  Rx<MovieDetailModel> movieDetail = MovieDetailModel().obs;

  getMovieDetail(int movieId) async {
    loading(true);
    AppServices appServices = AppServices();
    movieDetail.value = await appServices.getMovieDetail(movieId);
    loading(false);
  }
}
