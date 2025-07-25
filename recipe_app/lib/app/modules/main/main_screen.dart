import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/app/modules/favorites/favorites_screen.dart';
import 'package:recipe_app/app/modules/home/home_screen.dart';
import 'package:recipe_app/app/modules/main/main_controller.dart';
import 'package:recipe_app/app/modules/profile/profile_screen.dart';
import 'package:recipe_app/app/modules/search/main_search_screen.dart';

class MainScreen extends GetView<MainController> {
  final List<Widget> screens = [
    HomeScreen(),
    MainSearchScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];

  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Obx(() => IndexedStack(
            index: controller.tabIndex.value,
            children: screens,
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        elevation: 2.0,
        backgroundColor: Colors.amber,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: '', 
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            activeIcon: Icon(Icons.search_outlined),
            label: '', 
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border),
            activeIcon: Icon(Icons.bookmark),
            label: '', 
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: '',
          ),
        ],
        currentIndex: controller.tabIndex.value,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false, 
        showUnselectedLabels: false, 
        type: BottomNavigationBarType.fixed,
        onTap: controller.changeTabIndex, 
      )),
    );
  }
}