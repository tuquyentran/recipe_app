import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/app/routes/app_pages.dart';
import 'package:recipe_app/app/widgets/favorite.dart';
import 'favorites_controller.dart';

class FavoritesScreen extends GetView<FavoritesController> {
  const FavoritesScreen({super.key});

   @override
  Widget build(BuildContext context) {
    controller.fetchFavoriteMeals();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Công thức đã lưu'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.favoriteMeals.isEmpty) {
          return const Center(
            child: Text(
              'Bạn chưa có công thức yêu thích nào.',
              textAlign: TextAlign.center,
            ),
          );
        }
        return GridView.builder(
          padding: const EdgeInsets.all(16.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: controller.favoriteMeals.length,
          itemBuilder: (context, index) {
            final meal = controller.favoriteMeals[index];
            return FavoriteCard(
              imageUrl: meal.strMealThumb,
              mealName: meal.strMeal,
              author: "By User",
              onTap: () async {
                await Get.toNamed(Routes.detail, arguments: meal.idMeal);
                controller.fetchFavoriteMeals();
              },
            );
          },
        );
      }),
    );
  }
}