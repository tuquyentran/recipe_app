class Category {
  final String strCategory;
  Category({required this.strCategory});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(strCategory: json['strCategory']);
  }
}