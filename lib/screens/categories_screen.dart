import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';

import '../components/category_item.dart';

class CategoriesScreem extends StatelessWidget {
  const CategoriesScreem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: DUMMY_CATEGORIES
            .map((category) => CategoryItem(category: category))
            .toList(),
      ),
    );
  }
}
