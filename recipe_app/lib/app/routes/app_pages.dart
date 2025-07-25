import 'package:get/get.dart';
import 'package:recipe_app/app/modules/detail/detail_controller.dart';
import 'package:recipe_app/app/modules/detail/detail_screen.dart';
import 'package:recipe_app/app/modules/favorites/favorites_controller.dart';
import 'package:recipe_app/app/modules/favorites/favorites_screen.dart';
import 'package:recipe_app/app/modules/home/home_controller.dart';
import 'package:recipe_app/app/modules/home/home_screen.dart';
import 'package:recipe_app/app/modules/main/main_binding.dart';
import 'package:recipe_app/app/modules/main/main_screen.dart';
import 'package:recipe_app/app/modules/search/filter_controller.dart';
import 'package:recipe_app/app/modules/search/main_search_controller.dart';
import 'package:recipe_app/app/modules/search/main_search_screen.dart';
import 'package:recipe_app/app/modules/search/search_controller.dart';
import 'package:recipe_app/app/modules/splash/splash_screen.dart';
import 'package:recipe_app/app/modules/search/search_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.splash;

  static final routes = [
    GetPage(
      name: _Paths.splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: _Paths.main,
      page: () => MainScreen(),
      binding: MainBinding(), // Binding tất cả controller cần thiết
    ),
    GetPage(
      name: _Paths.home,
      page: () => HomeScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<HomeController>(() => HomeController());
      }),
    ),
  GetPage(
      name: _Paths.search,
      page: () => SearchScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<SearchScreenController>(() => SearchScreenController());
      }),
    ),
   GetPage(
      name: _Paths.mainsearch,
      page: () => MainSearchScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<MainSearchController>(() => MainSearchController());
         Get.lazyPut<FilterController>(() => FilterController());
      }),
    ),
    GetPage(
      name: _Paths.detail,
      page: () => MealDetailScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<DetailController>(() => DetailController());
      }),
    ),
    GetPage(
      name: _Paths.favorites,
      page: () => FavoritesScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<FavoritesController>(() => FavoritesController());
      }),
    ),
  ];
}