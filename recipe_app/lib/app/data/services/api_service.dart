import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recipe_app/app/data/models/area_model.dart';
import 'package:recipe_app/app/data/models/ingredient_model.dart';
import '../models/category_model.dart';
import '../models/meal_model.dart';

class ApiService {
  static const String _baseUrl = 'https://www.themealdb.com/api/json/v1/1';

  static Future<List<Meal>> searchMeal(String query) async {
    final response = await http.get(Uri.parse('$_baseUrl/search.php?s=$query'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['meals'] != null) {
        return (data['meals'] as List).map((m) => Meal.fromJson(m)).toList();
      }
    }
    return [];
  }

  static Future<List<Meal>> fetchRandomMeals() async {
    List<Meal> randomMeals = [];
    try {
      for (int i = 0; i < 10; i++) {
        final response = await http.get(Uri.parse('$_baseUrl/random.php'));
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          if (data['meals'] != null) {
            randomMeals.add(Meal.fromJson(data['meals'][0]));
          }
        }
      }
    } catch (e) {}
    return randomMeals;
  }

  static Future<List<Category>> fetchCategories() async {
    final response = await http.get(Uri.parse('$_baseUrl/list.php?c=list'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['meals'] != null) {
        return (data['meals'] as List)
            .map((c) => Category.fromJson(c))
            .toList();
      }
    }
    return [];
  }

  static Future<List<Ingredient>> fetchIngredients() async {
    final response = await http.get(Uri.parse('$_baseUrl/list.php?i=list'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['meals'] != null) {
        return (data['meals'] as List)
            .map((i) => Ingredient.fromJson(i))
            .toList();
      }
    }
    return [];
  }

  static Future<List<Area>> fetchAreas() async {
    final response = await http.get(Uri.parse('$_baseUrl/list.php?a=list'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['meals'] != null) {
        return (data['meals'] as List)
            .map((a) => Area.fromJson(a))
            .toList();
      }
    }
    return [];
  }

  static Future<Meal?> fetchMealDetails(String id) async {
    final response = await http.get(Uri.parse('$_baseUrl/lookup.php?i=$id'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['meals'] != null) {
        return Meal.fromJson(data['meals'][0]);
      }
    }
    return null;
  }
}
