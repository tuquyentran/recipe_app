import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/app/data/models/meal_model.dart';
import 'package:recipe_app/app/data/services/api_service.dart';

class MainSearchController extends GetxController {
  var searchResults = <Meal>[].obs;
  var isLoading = false.obs;
  var hasSearched = false.obs;
  final TextEditingController textController = TextEditingController();

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }

  void searchMeal(String query) async {
    if (query.isEmpty) return;
    try {
      hasSearched.value = true;
      isLoading(true);
      var meals = await ApiService.searchMeal(query);
      searchResults.assignAll(meals);
    } finally {
      isLoading(false);
    }
  }

  void filterMeals({String? category, String? ingredient, String? area}) async {
    try {
      isLoading(true);
      hasSearched.value = true;
      List<Meal> filteredMeals = [];

      if (category != null && category.isNotEmpty) {
        final categoryMeals = await ApiService.searchMeal(category);

        filteredMeals.addAll(categoryMeals);
      }
      if (ingredient != null && ingredient.isNotEmpty) {
        final ingredientMeals = await ApiService.searchMeal(ingredient);
        filteredMeals.addAll(ingredientMeals);
      }
      if (area != null && area.isNotEmpty) {
        final areaMeals = await ApiService.searchMeal(area);

        filteredMeals.addAll(areaMeals);
      }

      searchResults.assignAll(filteredMeals);
    } finally {
      isLoading(false);
    }
  }
}
