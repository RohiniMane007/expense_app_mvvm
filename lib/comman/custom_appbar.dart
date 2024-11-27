import 'package:expense_app/core/utils/custom_textstyle.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;

  // Constructor
  const CustomAppBar({
    super.key,
    required this.title,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style:
            CustomTextStyle.titleTextStyle(fontsize: 22, color: Colors.white),
      ),
      centerTitle: true, // Optional, for centering the title
      backgroundColor:
          Colors.teal, // You can change this to any color or gradient
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: CircleAvatar(),
        )
      ],
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight); // Standard height for AppBar
}
