import 'package:flutter/material.dart';
import 'package:nicholas_nutrihaven/Utils/Const/color_const.dart';

class CustomTabBarWidget extends StatelessWidget {
  final List<String> tabTitles;

  const CustomTabBarWidget({
    super.key,
    required this.tabTitles,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      labelColor: Colors.black,
      unselectedLabelColor: Colors.grey,
      indicatorColor: primary,
      tabs: tabTitles.map((title) => Tab(text: title)).toList(),
    );
  }
}
