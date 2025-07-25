import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/app/modules/search/search_controller.dart';
import 'package:recipe_app/app/routes/app_pages.dart';

class SearchScreen extends GetView<SearchScreenController> {
  const SearchScreen({super.key});

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
              hintText: 'Tìm kiếm...',
              prefixIcon: const Icon(Icons.search),
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
              fillColor: Colors.grey[100],
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            ),
            onSubmitted: (query) {
              controller.searchMeal(query);
            },
          ),
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.hasSearched.value &&
              controller.searchResults.isEmpty) {
            return const Center(child: Text('Không tìm thấy món ăn nào.'));
          } else if (controller.hasSearched.value) {
            return ListView.builder(
              itemCount: controller.searchResults.length,
              itemBuilder: (context, index) {
                final meal = controller.searchResults[index];
                return ListTile(
                  title: Text(meal.strMeal),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Get.toNamed(Routes.detail, arguments: meal.idMeal);
                  },
                );
              },
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.showAllHistory.value
                      ? controller.searchHistory.length
                      : (controller.searchHistory.length > 4
                          ? 4
                          : controller.searchHistory.length),
                  itemBuilder: (context, index) {
                    final term = controller.searchHistory[index];
                    return ListTile(
                      leading: const Icon(Icons.history),
                      title: Text(term),
                      onTap: () {
                        controller.textController.text = term;
                        controller.searchMeal(term);
                      },
                    );
                  },
                ),
                Obx(() => controller.searchHistory.isNotEmpty
                    ? TextButton(
                        onPressed: () {
                          controller.showAllHistory.value =
                              !controller.showAllHistory.value;
                        },
                        child: Text(controller.searchHistory.length > 4 &&
                                !controller.showAllHistory.value
                            ? 'Xem Thêm'
                            : 'Xóa Lịch Sử'),
                      )
                    : const SizedBox.shrink()),
              ],
            );
          }
        }),
      ),
    );
  }
}