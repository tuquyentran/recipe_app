import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String imageUrl;
  final String mealName;
  final String author;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.imageUrl,
    required this.mealName,
    required this.author,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        // --- nền ---
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 180,
            height: 500,
            margin: const EdgeInsets.only(top: 40), 
            decoration: BoxDecoration(
              color: const Color(0xFFF0EAD6),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 60, 10, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    mealName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF603813),
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Tạo bởi',
                    style: TextStyle(color: Color(0xFF432805), fontSize: 12, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    author,
                    style: TextStyle(
                      color: Color(0xFF432805),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(), 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '20 phút', 
                        style: TextStyle(color: Color(0xFF432805), fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Icon(Icons.article_outlined, color: Color(0xFF432805), size: 30),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        // --- ảnh ---
        Positioned(
          top: 0, 
          child: CircleAvatar(
            radius: 45, 
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 40, 
              backgroundImage: NetworkImage(imageUrl),
              onBackgroundImageError: (exception, stackTrace) {
              },
            ),
          ),
        ),
      ],
    );
  }
}