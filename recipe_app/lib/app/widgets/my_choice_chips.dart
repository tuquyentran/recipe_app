// lib/app/widgets/my_choice_chips.dart
import 'package:flutter/material.dart';

class MyChoiceChips extends StatelessWidget {
  final List<String> items;
  final String? selectedItem;
  final Function(String) onSelected;

  const MyChoiceChips({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: items.map((item) {
        bool isSelected = selectedItem == item;
        return ChoiceChip(
          label: Text(item),
          selected: isSelected,
          onSelected: (selected) {
            onSelected(item);
          },
          backgroundColor: Colors.white,
          selectedColor: Colors.amber,
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: isSelected ? Colors.amber : Colors.grey.shade300,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          showCheckmark: false,
        );
      }).toList(),
    );
  }
}