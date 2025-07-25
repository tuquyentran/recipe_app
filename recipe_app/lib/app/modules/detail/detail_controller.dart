import 'package:get/get.dart';
import 'package:recipe_app/app/data/services/favorite_service.dart';
import '../../data/models/meal_model.dart';
import '../../data/services/api_service.dart';

class DetailController extends GetxController {
  var meal = Rxn<Meal>();
  var isLoading = true.obs;
  var isFavorite = false.obs;
  final String mealId = Get.arguments;

  @override
  void onInit() {
    fetchMealDetails();
    super.onInit();
  }

  void fetchMealDetails() async {
    try {
      isLoading(true);
      meal.value = await ApiService.fetchMealDetails(mealId);
      if (meal.value != null) {
        checkIfFavorite();
      }
    } finally {
      isLoading(false);
    }
  }

   void checkIfFavorite() async {
    isFavorite.value = await FavoriteService.isFavorite(mealId);
  }

  void toggleFavorite() async {
    if (isFavorite.value) {
      await FavoriteService.removeFavorite(mealId);
      isFavorite.value = false;
    } else {
      await FavoriteService.addFavorite(mealId);
      isFavorite.value = true;
    }
  }
}