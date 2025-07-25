 import 'package:get/get.dart';
import 'package:recipe_app/app/data/models/area_model.dart';
import 'package:recipe_app/app/data/models/category_model.dart';
import 'package:recipe_app/app/data/models/ingredient_model.dart';
import 'package:recipe_app/app/data/services/api_service.dart';

class FilterController extends GetxController {
  var categories = <Category>[].obs;
  var ingredients = <Ingredient>[].obs;
  var areas = <Area>[].obs;
  var isLoading = false.obs;

  var selectedCategory = Rxn<String>();
  var selectedIngredient = Rxn<String>();
  var selectedArea = Rxn<String>();

  @override
  void onInit() {
    super.onInit();
    loadFilterOptions();
  }

  Future<void> loadFilterOptions() async {
    try {
      isLoading(true);
      categories.value = await ApiService.fetchCategories();
      ingredients.value = await ApiService.fetchIngredients();
      areas.value = await ApiService.fetchAreas();
    } catch (e) {
      Get.snackbar('Error', 'Không thể tải dữ liệu bộ lọc.');
    } finally {
      isLoading(false);
    }
  }

  void resetFilters() {
    selectedCategory.value = null;
    selectedIngredient.value = null;
    selectedArea.value = null;
  }

  void selectCategory(String category) {
    selectedCategory.value = category;
  }

  void selectIngredient(String ingredient) {
    selectedIngredient.value = ingredient;
  }

  void selectArea(String area) {
    selectedArea.value = area;
  }
}