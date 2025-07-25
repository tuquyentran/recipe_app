class Ingredient {
  final String strIngredient;
  Ingredient({required this.strIngredient});

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(strIngredient: json['strIngredient']);
  }
}
