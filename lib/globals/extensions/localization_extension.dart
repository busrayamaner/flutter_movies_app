import 'package:get/get.dart';

extension LocalizationExtension on String {
  String get translate => tr;

  String translateParams([Map<String, String> params = const {}]) {
    return trParams(params);
  }
}
