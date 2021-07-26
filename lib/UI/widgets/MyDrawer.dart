import 'package:FrontEnd/UI/behaviors/AppLocalizations.dart';
import 'package:FrontEnd/UI/pages/Contacts.dart';
import 'package:FrontEnd/UI/pages/Home.dart';
import 'package:FrontEnd/UI/pages/Layout.dart';
import 'package:FrontEnd/UI/pages/NoOrders.dart';
import 'package:FrontEnd/UI/pages/Orders.dart';
import 'package:FrontEnd/UI/pages/Search.dart';
import 'package:FrontEnd/UI/pages/ShoppingCart.dart';
import 'package:FrontEnd/UI/pages/ShoppingCartNo.dart';
import 'package:FrontEnd/UI/pages/UserLogin.dart';
import 'package:FrontEnd/UI/pages/UserLogout.dart';
import 'package:FrontEnd/model/Model.dart';
import 'package:FrontEnd/model/support/extensions/StringCapitalization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'CircularIconButton.dart';

enum DrawerItemTypes { HOME, SEARCH, CONTACTS, CART, ORDERS }

class MyDrawer extends StatefulWidget {
  final DrawerItemTypes selected;

  MyDrawer({Key key, this.selected}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState(selected);
}

class _MyDrawerState extends State<MyDrawer> {
  DrawerItemTypes _selectedDrawerItemIndex;

  _MyDrawerState(DrawerItemTypes selected) {
    this._selectedDrawerItemIndex = selected;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 20.0,
      child: ListView(
        children: [
          DrawerHeader(
            child: Column(children: [
              Row(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: CircularIconButton(
                      icon: Icons.person,
                      onPressed: () {
                        _login();
                      },
                    ),
                  ),
                  Model.sharedInstance.logged
                      ? Padding(
                          padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                          child: CircularIconButton(
                            icon: Icons.logout,
                            onPressed: () {
                              _logout();
                            },
                          ),
                        )
                      : Container(),
                ],
              ),
              Row(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: Text(
                        Model.sharedInstance.userLogged,
                        style: TextStyle(
                            color: Theme.of(context).backgroundColor,
                            fontSize: 20.0),
                      ),
                    ),
                  ),
                ],
              ),
            ]),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          ListTile(
            selectedTileColor: Theme.of(context).cardColor,
            hoverColor: Theme.of(context).textSelectionColor,
            leading: Icon(
              Icons.home,
              color: Theme.of(context).primaryColorDark,
            ),
            title: Text(
              AppLocalizations.of(context).translate("home").capitalize,
              style: TextStyle(color: Theme.of(context).primaryColorDark),
            ),
            selected: _selectedDrawerItemIndex == DrawerItemTypes.HOME,
            autofocus: _selectedDrawerItemIndex == DrawerItemTypes.HOME,
            onTap: () => _onSelectDrawerItem(DrawerItemTypes.HOME),
          ),
          ListTile(
            selectedTileColor: Theme.of(context).cardColor,
            hoverColor: Theme.of(context).textSelectionColor,
            leading: Icon(
              Icons.search,
              color: Theme.of(context).primaryColorDark
            ),
            title: Text(
              AppLocalizations.of(context).translate("search").capitalize,
              style: TextStyle(color: Theme.of(context).primaryColorDark),
            ),
            selected: _selectedDrawerItemIndex == DrawerItemTypes.SEARCH,
            autofocus: _selectedDrawerItemIndex == DrawerItemTypes.SEARCH,
            onTap: () => _onSelectDrawerItem(DrawerItemTypes.SEARCH),
          ),
          ListTile(
            selectedTileColor: Theme.of(context).cardColor,
            hoverColor: Theme.of(context).textSelectionColor,
            leading: Icon(
              Icons.info,
              color: Theme.of(context).primaryColorDark
            ),
            title: Text(
              AppLocalizations.of(context).translate("contacts").capitalize,
              style: TextStyle(color: Theme.of(context).primaryColorDark),
            ),
            selected: _selectedDrawerItemIndex == DrawerItemTypes.CONTACTS,
            autofocus: _selectedDrawerItemIndex == DrawerItemTypes.CONTACTS,
            onTap: () => _onSelectDrawerItem(DrawerItemTypes.CONTACTS),
          ),
          ListTile(
            selectedTileColor: Theme.of(context).cardColor,
            hoverColor: Theme.of(context).textSelectionColor,
            leading: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).primaryColorDark
            ),
            title: Text(
              AppLocalizations.of(context).translate("cart").capitalize,
              style: TextStyle(color: Theme.of(context).primaryColorDark),
            ),
            selected: _selectedDrawerItemIndex == DrawerItemTypes.CART,
            autofocus: _selectedDrawerItemIndex == DrawerItemTypes.CART,
            onTap: () => _onSelectDrawerItem(DrawerItemTypes.CART),
          ),
          ListTile(
            selectedTileColor: Theme.of(context).cardColor,
            hoverColor: Theme.of(context).textSelectionColor,
            leading: Icon(
              Icons.list_alt_outlined,
              color: Theme.of(context).primaryColorDark
            ),
            title: Text(
              AppLocalizations.of(context).translate("order").capitalize,
              style: TextStyle(color: Theme.of(context).primaryColorDark),
            ),
            selected: _selectedDrawerItemIndex == DrawerItemTypes.ORDERS,
            autofocus: _selectedDrawerItemIndex == DrawerItemTypes.ORDERS,
            onTap: () => _onSelectDrawerItem(DrawerItemTypes.ORDERS),
          )
        ],
      ),
    );
  }

  _onSelectDrawerItem(DrawerItemTypes type) {
    Navigator.of(context).pop(); // close the drawer
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        transitionDuration: Duration(milliseconds: 700),
        pageBuilder: (BuildContext context, _, __) =>
            Layout(page: _getDrawerItemWidget(type), selected: type),
      ),
    );
  }

  _getDrawerItemWidget(DrawerItemTypes type) {
    switch (type) {
      case DrawerItemTypes.HOME:
        return Home();
      case DrawerItemTypes.SEARCH:
        return Search();
      case DrawerItemTypes.CONTACTS:
        return Contacts();
      case DrawerItemTypes.ORDERS:
        if (Model.sharedInstance.logged) return Orders();
        return NoOrders();
      case DrawerItemTypes.CART:
        if (Model.sharedInstance.logged) return ShoppingCart();
        return ShoppingCartNo();
      default:
        return Text("Error");
    }
  }

  void _login() {
    Navigator.of(context).pop();
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        transitionDuration: Duration(milliseconds: 800),
        pageBuilder: (BuildContext context, _, __) => Layout(
            page: !Model.sharedInstance.logged
                ? UserLogin()
                : UserLogout(userLogged: Model.sharedInstance.userLogged)),
      ),
    );
  }

  void _logout() {
    Model.sharedInstance.logOut().then((result) {
      Navigator.of(context).pop();
      Navigator.of(context).push(
        PageRouteBuilder(
          opaque: false,
          transitionDuration: Duration(milliseconds: 800),
          pageBuilder: (BuildContext context, _, __) => Layout(page: Home()),
        ),
      );
    });
  }
}
