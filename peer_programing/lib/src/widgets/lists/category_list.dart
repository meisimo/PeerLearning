import 'package:flutter/material.dart';
import 'package:peer_programing/src/theme/color/light_color.dart';
import 'package:peer_programing/src/widgets/inputs/tag_chip.dart';
import 'package:peer_programing/src/helper/mentoring_category_model.dart';

class CategoryList extends StatefulWidget {
  final double dividerWidth;
  final List<MentoringCategory> categories;
  final Function onTap;
  final String title;
  final bool wrap;
  final bool usePadding, chipConstraints;

  CategoryList({key, this.dividerWidth, this.categories, this.onTap, this.title = "", this.wrap = false, this.usePadding = false, this.chipConstraints = false})
      : super(key: key);

  @override
  StateCategoryList createState() => new StateCategoryList(
      dividerWidth: this.dividerWidth,
      categories: this.categories,
      onTap: this.onTap,
      title: this.title,
      wrap: this.wrap,
      usePadding: this.usePadding,
      chipConstraints: this.chipConstraints,
  );
}

class StateCategoryList extends State<CategoryList> {
  final double dividerWidth;
  final Function onTap;
  final String title;
  final bool wrap;
  final bool usePadding, chipConstraints;

  List<MentoringCategory> categories;

  StateCategoryList({this.dividerWidth, this.categories, this.onTap, this.title = "", this.wrap = false, this.usePadding, this.chipConstraints});

  Widget _showEmpty() => Text(
          title,
          style: TextStyle(
              color: LightColor.extraDarkPurple, fontWeight: FontWeight.bold),
        );

  @override
  Widget build(BuildContext context) {
    if (categories.length < 1)
      return _showEmpty();
    
    List<Widget> categoryList = [];
    categories.forEach((category) {
      categoryList.add(TagChip(
        category.name,
        category.color,
        height: 5,
        usePadding: this.usePadding,
        dividerWidth: dividerWidth,
        id: category.id,
        onTap: this.onTap != null ? this.onTap(category) : null,
        chipConstraints: chipConstraints,
      ));
    });

    if (wrap){
      return Wrap(
        children: categoryList
      );
    }
    return ListView(
      scrollDirection: Axis.horizontal,
      children: categoryList,
    );
  }

  void setCategories(categories){
    setState(() {
      this.categories = categories;
    });
  }
}
