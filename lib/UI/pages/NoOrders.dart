import 'package:FrontEnd/UI/behaviors/AppLocalizations.dart';
import 'package:FrontEnd/model/objects/Acquisto.dart';
import 'package:FrontEnd/model/support/extensions/StringCapitalization.dart';
import 'package:flutter/material.dart';

import 'Layout.dart';
import 'UserLogin.dart';

class NoOrders extends StatefulWidget {
  NoOrders({Key key}) : super(key: key);

  @override
  _NoOrdersState createState() => _NoOrdersState();
}

class _NoOrdersState extends State<NoOrders> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
        child: Column(
          children: [
            Text(
              AppLocalizations.of(context).translate("no_log_orders"),
              style: TextStyle(
                fontSize: 30,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 300,
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: TextButton(
                child: Text(
                  AppLocalizations.of(context).translate("just_reg").capitalize,
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                onPressed: () {
                  _login();
                },
              ),
            )
          ],
        ));
  }

  void _login() {
    Navigator.of(context).pop();
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        transitionDuration: Duration(milliseconds: 800),
        pageBuilder: (BuildContext context, _, __) => Layout(page: UserLogin()),
      ),
    );
  }
}
