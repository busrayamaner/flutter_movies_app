import 'package:get/get.dart';
import 'package:movies_app/models/category_model.dart';
import 'package:movies_app/services/app_service.dart';

class CategoryController extends GetxController {
  RxBool loading = false.obs;
  Rx<CategoryModel> categoryList = CategoryModel(genres: []).obs;

  getCategoryList() async {
    loading(true);
    AppServices appServices = AppServices();
    categoryList.value = await appServices.getCategoryList();
    loading(false);
  }
}
