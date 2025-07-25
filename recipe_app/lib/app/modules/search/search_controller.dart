import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/app/data/models/meal_model.dart';
import 'package:recipe_app/app/data/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchScreenController extends GetxController {
  var searchResults = <Meal>[].obs;
  var isLoading = false.obs;
  var hasSearched = false.obs;
  var searchHistory = <String>[].obs;
  var showAllHistory = false.obs;
  final TextEditingController textController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadSearchHistory();
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }

  Future<void> loadSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    searchHistory.value = prefs.getStringList('searchHistory') ?? [];
  }

  Future<void> saveSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('searchHistory', searchHistory);
  }

  void addSearchTerm(String term) {
    if (!searchHistory.contains(term)) {
      searchHistory.insert(0, term);
      if (searchHistory.length > 10) {
        searchHistory.removeLast();
      }
      saveSearchHistory();
    }
  }

  void clearSearchHistory() {
    searchHistory.clear();
    showAllHistory.value = false;
    saveSearchHistory();
  }

  void searchMeal(String query) async {
    if (query.isEmpty) return;
    try {
      hasSearched.value = true;
      isLoading(true);
      addSearchTerm(query); 
      var meals = await ApiService.searchMeal(query);
      searchResults.assignAll(meals);
    } finally {
      isLoading(false);
    }
  }
}