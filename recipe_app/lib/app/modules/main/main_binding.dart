import 'package:get/get.dart';
import 'package:recipe_app/app/modules/favorites/favorites_controller.dart';
import 'package:recipe_app/app/modules/home/home_controller.dart';
import 'package:recipe_app/app/modules/search/filter_controller.dart';
import 'package:recipe_app/app/modules/search/main_search_controller.dart';
import 'main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<MainSearchController>(() => MainSearchController());
    Get.lazyPut<FilterController>(() => FilterController());
    Get.lazyPut<FavoritesController>(() => FavoritesController());
  }
}