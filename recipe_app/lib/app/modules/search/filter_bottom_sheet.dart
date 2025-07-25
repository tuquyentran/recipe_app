import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/app/modules/search/main_search_controller.dart';
import 'package:recipe_app/app/modules/search/filter_controller.dart';
import 'package:recipe_app/app/widgets/my_choice_chips.dart';

class FilterBottomSheet extends GetView<FilterController> {
  const FilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Lọc',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      controller.resetFilters();
                    },
                    child: const Text(
                      'Đặt lại',
                      style: TextStyle(color: Color(0xFFCEA700)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // --- Danh mục ---
              const Text(
                'Danh mục',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              MyChoiceChips(
                  items: controller.categories.take(5).map((e) => e.strCategory).toList(),
                  selectedItem: controller.selectedCategory.value,
                  onSelected: (String category) {
                    controller.selectCategory(category);
                  },
                ),
                const SizedBox(height: 16),
                // --- Nguyên liệu ---
                const Text('Nguyên liệu', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                MyChoiceChips(
                  items: controller.ingredients.take(5).map((e) => e.strIngredient).toList(),
                  selectedItem: controller.selectedIngredient.value,
                  onSelected: (String ingredient) {
                    controller.selectIngredient(ingredient);
                  },
                ),
                const SizedBox(height: 16),
                // --- Khu vực ---
                const Text('Khu vực', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                MyChoiceChips(
                  items: controller.areas.take(5).map((e) => e.strArea).toList(),
                  selectedItem: controller.selectedArea.value,
                  onSelected: (String area) {
                    controller.selectArea(area);
                  },
                ),
                const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Get.find<MainSearchController>().filterMeals(
                    category: controller.selectedCategory.value,
                    ingredient: controller.selectedIngredient.value,
                    area: controller.selectedArea.value,
                  );
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFCEA700),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  textStyle: const TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Xác nhận',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
            ],
          );
        }
      }),
    );
  }
}