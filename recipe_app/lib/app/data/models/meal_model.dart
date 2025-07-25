class Meal {
  final String idMeal;
  final String strMeal;
  final String strMealThumb;
  final String? strInstructions;
  final List<String> ingredients;
  final List<String> measures;

  Meal({
    required this.idMeal, required this.strMeal, required this.strMealThumb,
    this.strInstructions, this.ingredients = const [], this.measures = const [],
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    List<String> ingredients = [];
    List<String> measures = [];
    for (int i = 1; i <= 20; i++) {
      final ingredient = json['strIngredient$i'];
      if (ingredient != null && ingredient.isNotEmpty) {
        ingredients.add(ingredient);
        measures.add(json['strMeasure$i'] ?? '');
      } else {
        break;
      }
    }
    return Meal(
      idMeal: json['idMeal'], strMeal: json['strMeal'], strMealThumb: json['strMealThumb'],
      strInstructions: json['strInstructions'], ingredients: ingredients, measures: measures,
    );
  }
}