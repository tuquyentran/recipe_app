import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/app/data/models/meal_model.dart';
import 'package:recipe_app/app/modules/search/filter_bottom_sheet.dart';
import 'package:recipe_app/app/modules/search/main_search_controller.dart';

class MainSearchScreen extends GetView<MainSearchController> {
  const MainSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 1,
          title: TextField(
            controller: controller.textController,
            decoration: InputDecoration(
              hintText: 'Tìm kiếm món ăn...',
              border: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[300],
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                suffixIcon: IconButton(onPressed: () { showModalBottomSheet(
                    context: context,
                    isScrollControlled: true, 
                    builder: (context) => const FilterBottomSheet()); }, icon: const Icon(Icons.filter_alt,color: Color(0xFFCEA700), size: 30,),),
            ),
            onSubmitted: (query) {
              controller.searchMeal(query);
            },
          ),
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.searchResults.isEmpty) {
            return const Center(child: Text('Không tìm thấy món ăn nào.'));
          } else {
            return GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, 
                childAspectRatio: 0.7,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: controller.searchResults.length,
              itemBuilder: (context, index) {
                final meal = controller.searchResults[index];
                return _buildMealCard(meal);
              },
            );
          }
        }),
      ),
    );
  }

  Widget _buildMealCard(Meal meal) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(meal.strMealThumb, fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.fastfood, size: 50),),
              ),
            ),
            const SizedBox(height: 8),
            Text(meal.strMeal,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
            const SizedBox(height: 4),
            const Text('By Little Pony', style: TextStyle(fontSize: 12, color: Colors.grey)),
            Row(
              children: [
                const Icon(Icons.access_time, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                const Text('20 min', style: TextStyle(fontSize: 12, color: Colors.grey)),
                const Spacer(),
                Icon(Icons.favorite, size: 14, color: Colors.red.shade400),
              ],
            ),
          ],
        ),
      ),
    );
  }
}