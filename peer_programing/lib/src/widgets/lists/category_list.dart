import 'package:flutter/material.dart';
import 'package:peer_programing/src/theme/color/light_color.dart';
import 'package:peer_programing/src/widgets/inputs/tag_chip.dart';
import 'package:peer_programing/src/helper/mentoring_category_model.dart';

class CategoryList extends StatefulWidget {
  final double dividerWidth;
  final List<MentoringCategory> categories;
  final Function onTap;
  final String title;

  CategoryList({key, this.dividerWidth, this.categories, this.onTap, this.title = ""})
      : super(key: key);

  @override
  StateCategoryList createState() => new StateCategoryList(
      dividerWidth: this.dividerWidth,
      categories: this.categories,
      onTap: this.onTap,
      title: this.title
  );
}

class StateCategoryList extends State<CategoryList> {
  final double dividerWidth;
  final Function onTap;
  final String title;

  List<MentoringCategory> categories;

  StateCategoryList({this.dividerWidth, this.categories, this.onTap, this.title = ""});

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
    Widget divider = SizedBox(
      width: dividerWidth,
    );
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

  void setCategories(categories){
    setState(() {
      this.categories = categories;
    });
  }
}
