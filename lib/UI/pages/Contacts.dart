import 'package:FrontEnd/UI/behaviors/AppLocalizations.dart';
import 'package:FrontEnd/model/support/extensions/StringCapitalization.dart';
import 'package:flutter/material.dart';

class Contacts extends StatefulWidget {
  Contacts({Key key}) : super(key: key);

  @override
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 40, 0, 10),
              child: Text(
                AppLocalizations.of(context).translate("contacts").capitalize,
                style: TextStyle(
                  fontSize: 50,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: Text(
                AppLocalizations.of(context).translate("cont_addr").capitalize,
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Text(
                AppLocalizations.of(context).translate("cont_telep").capitalize,
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Text(
                AppLocalizations.of(context).translate("cont_email").capitalize,
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
