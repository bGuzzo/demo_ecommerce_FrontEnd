import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

enum AppBarItemTypes { ACCOUNTING, SHOPPING_CART }

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  MyAppBar({Key key, this.title}) : super(key: key);

  @override
  _MyAppBarState createState() => _MyAppBarState(title);

  @override
  Size get preferredSize => Size.fromHeight(56);
}

class _MyAppBarState extends State<MyAppBar> {
  String title;

  _MyAppBarState(String title) {
    this.title = title;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).backgroundColor,
          fontSize: 20,
        ),
      ),
      centerTitle: true,
    );
  }
}
