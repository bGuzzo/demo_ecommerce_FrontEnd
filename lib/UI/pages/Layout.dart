import 'package:FrontEnd/UI/widgets/MyAppBar.dart';
import 'package:FrontEnd/UI/widgets/MyDrawer.dart';
import 'package:FrontEnd/model/support/Constants.dart';
import 'package:flutter/material.dart';

class Layout extends StatefulWidget {
  final String title = Constants.APP_NAME;
  final Widget page;
  final DrawerItemTypes selected;

  Layout({Key key, this.page, this.selected}) : super(key: key);

  @override
  _LayoutState createState() => _LayoutState(page, selected, title);
}

class _LayoutState extends State<Layout> {
  String title;
  DrawerItemTypes _selectedDrawerItemIndex;
  Widget page;

  _LayoutState(Widget page, DrawerItemTypes selected, String title) {
    this.page = page;
    this._selectedDrawerItemIndex = selected;
    this.title = title;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        resizeToAvoidBottomInset: false,
        appBar: MyAppBar(title: title),
        drawer: MyDrawer(selected: _selectedDrawerItemIndex),
        body: page);
  }
}
