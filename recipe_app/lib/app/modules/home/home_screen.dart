import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/app/routes/app_pages.dart';
import 'package:recipe_app/app/widgets/category_card.dart';
import 'package:recipe_app/app/widgets/my_choice_chips.dart';
import 'package:recipe_app/app/widgets/recent_recipe_card.dart';
import 'package:recipe_app/app/widgets/video_recipe_card.dart';
import 'package:recipe_app/app/widgets/section_header.dart';
import 'home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  Widget _buildHorizontalVideoRecipeList(List<dynamic> meals) {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: meals.take(6).length,
        itemBuilder: (context, index) {
          final meal = meals[index];
          return VideoRecipeCard(
            imageUrl: meal.strMealThumb,
            mealName: meal.strMeal,
            author: "Đinh Trọng Phúc",
            onTap: () => Get.toNamed(Routes.detail, arguments: meal.idMeal),
          );
        },
      ),
    );
  }

Widget _buildHorizontalCategoryChips() {
    final limitedCategories = controller.categories.take(6).toList();

    return Obx(() => SizedBox(
      height: 45,
      child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        child: MyChoiceChips(
          items: limitedCategories.map((e) => e.strCategory).toList(),
          selectedItem: controller.selectedCategoryName.value,
          onSelected: (String categoryName) {
            controller.selectCategory(categoryName);
          },
        ),
      ),
    ));
  }

  Widget _buildHorizontalCategoryList(List<dynamic> meals) {
    return SizedBox(
      height: 230,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: meals.take(6).length,
        itemBuilder: (context, index) {
          final meal = meals[index];
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CategoryCard(
              imageUrl: meal.strMealThumb,
              mealName: meal.strMeal,
              author: "Trần Đình Trọng",
              onTap: () => Get.toNamed(Routes.detail, arguments: meal.idMeal),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHorizontalRecentRecipeList(List<dynamic> meals) {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: meals.take(6).length,
        itemBuilder: (context, index) {
          final meal = meals[index];
          return RecentRecipe(
            imageUrl: meal.strMealThumb,
            mealName: meal.strMeal,
            author: "Trần Đình Trọng",
            onTap: () => Get.toNamed(Routes.detail, arguments: meal.idMeal),
          );
        },
      ),
    );
  }

  Widget _buildIngredientChips() {
    final limitedIngredients = controller.ingredients.take(8).toList();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: MyChoiceChips(
        items: limitedIngredients.map((e) => e.strIngredient).toList(),
        selectedItem: controller.selectedIngredientName.value,
        onSelected: (String ingredient) {
          controller.selectIngredient(ingredient);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        title: GestureDetector(
          onTap: () {
            Get.toNamed(Routes.search);
          },
          child: Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Row(
              children: [
                Icon(Icons.search, color: Colors.grey[600]),
                SizedBox(width: 8),
                Text(
                  'Tìm kiếm món ăn...',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionHeader(title: 'TP. Hồ Chí Minh', onViewAll: () {}),
              _buildHorizontalVideoRecipeList(controller.randomMeals),
              SectionHeader(title: 'Danh mục', onViewAll: () {}),
              _buildHorizontalCategoryChips(),
              const SizedBox(height: 16),
              _buildHorizontalCategoryList(controller.randomMeals),
              SectionHeader(title: 'Công thức gần đây', onViewAll: () {}),
              _buildHorizontalRecentRecipeList(
                controller.randomMeals.reversed.toList(),
              ),
              SectionHeader(title: 'Nguyên liệu', onViewAll: () {}),
              _buildIngredientChips(),
              const SizedBox(height: 20),
            ],
          ),
        );
      }),
    );
  }
}
