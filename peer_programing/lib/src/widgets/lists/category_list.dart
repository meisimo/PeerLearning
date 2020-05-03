import 'package:flutter/material.dart';
import 'package:peer_programing/src/widgets/inputs/tag_chip.dart';
import 'package:peer_programing/src/helper/mentoring_category_model.dart';

class CategoryList extends StatelessWidget {
  final double dividerWidth;
  final List<MentoringCategory> categories;
  final Function onTap;

  CategoryList({this.dividerWidth, this.categories, this.onTap});

  @override
  Widget build(BuildContext context) {
    List<Widget> categoryList = [];
    Widget divider = SizedBox(width: dividerWidth,);
    categories.forEach((category) {
      categoryList.add(divider);
      categoryList.add(TagChip(
        category.name,
        category.color,
        height: 5,
        id: category.id,
        onTap: this.onTap != null ? this.onTap(category) : null,
      ));
    });

    return ListView(
      scrollDirection: Axis.horizontal,
      children: categoryList,
    );
  }
}
