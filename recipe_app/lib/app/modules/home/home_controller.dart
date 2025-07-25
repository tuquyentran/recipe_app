import 'package:get/get.dart';
import 'package:recipe_app/app/data/models/category_model.dart';
import 'package:recipe_app/app/data/models/ingredient_model.dart';
import 'package:recipe_app/app/data/models/meal_model.dart';
import '../../data/services/api_service.dart';

class HomeController extends GetxController {
  var randomMeals = <Meal>[].obs;
  var categories = <Category>[].obs;
  var ingredients = <Ingredient>[].obs;
  var isLoading = true.obs;

  var selectedCategoryName = Rxn<String>();
  var selectedIngredientName = Rxn<String>();

  @override
  void onInit() {
    fetchAllData();
    super.onInit();
  }

  void fetchAllData() async {
    try {
      isLoading(true);
      final results = await Future.wait([
        ApiService.fetchRandomMeals(),
        ApiService.fetchCategories(),
        ApiService.fetchIngredients(),
      ]);
      randomMeals.assignAll(results[0] as List<Meal>);
      categories.assignAll(results[1] as List<Category>);
      ingredients.assignAll(results[2] as List<Ingredient>);
    } catch (e) {
      Get.snackbar('Lỗi', 'Tải dữ liệu thất bại: $e',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }

  void selectCategory(String categoryName) {
    selectedCategoryName.value = categoryName;
  }
  void selectIngredient(String ingredientName) {
    selectedIngredientName.value = ingredientName;
  }

}