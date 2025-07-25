import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'detail_controller.dart';

class MealDetailScreen extends GetView<DetailController> {
  const MealDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.meal.value == null) {
          return const Center(child: Text('Không tìm thấy công thức.'));
        }

        final meal = controller.meal.value!;
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 300.0,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(meal.strMeal, style: TextStyle(color: Colors.white, shadows: [Shadow(blurRadius: 10)])),
                background: Image.network(
                  meal.strMealThumb,
                  fit: BoxFit.cover,
                  color: Colors.black.withOpacity(0.3),
                  colorBlendMode: BlendMode.darken,
                ),
              ),
               actions: [
                Obx(() => IconButton(
                  icon: Icon(
                    controller.isFavorite.value ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                  ),
                  onPressed: () => controller.toggleFavorite(),
                )),
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Nguyên liệu', style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: 8),
                    for (int i = 0; i < meal.ingredients.length; i++)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text('• ${meal.measures[i]} ${meal.ingredients[i]}'),
                      ),
                    const SizedBox(height: 24),
                    Text('Chế biến', style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: 8),
                    Text(
                      meal.strInstructions ?? 'Không có hướng dẫn.',
                      style: TextStyle(height: 1.5, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}