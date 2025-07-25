import 'package:get/get.dart';
import 'package:recipe_app/app/data/services/api_service.dart';
import 'package:recipe_app/app/data/services/favorite_service.dart';
import '../../data/models/meal_model.dart';

class FavoritesController extends GetxController {
  var favoriteMeals = <Meal>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchFavoriteMeals();
    super.onInit();
  }

  void fetchFavoriteMeals() async {
    try {
      isLoading(true);
      final favoriteIds = await FavoriteService.getFavorites();
      if (favoriteIds.isEmpty) {
         favoriteMeals.clear();
         return;
      }

      List<Meal> meals = [];
      for (String id in favoriteIds) {
        final mealDetail = await ApiService.fetchMealDetails(id);
        if (mealDetail != null) {
          meals.add(mealDetail);
        }
      }
      favoriteMeals.assignAll(meals);
    } finally {
      isLoading(false);
    }
  }
}