import 'package:FrontEnd/UI/behaviors/AppLocalizations.dart';
import 'package:FrontEnd/UI/widgets/CircularIconButton.dart';
import 'package:FrontEnd/model/Model.dart';
import 'package:FrontEnd/model/support/extensions/StringCapitalization.dart';
import 'package:flutter/material.dart';

import 'Layout.dart';
import 'UserLogin.dart';

class UserLogout extends StatefulWidget {
  String userLogged;

  UserLogout({Key key, this.userLogged}) : super(key: key);

  @override
  _UserLogoutState createState() => _UserLogoutState(userLogged);
}

class _UserLogoutState extends State<UserLogout> {
  String userLogged = "";
  bool _loggingOut = false;

  _UserLogoutState(String userLogged) {
    if (userLogged != null) this.userLogged = userLogged;
  }

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
                AppLocalizations.of(context).translate("welcome").capitalize +
                    ", " +
                    userLogged +
                    "!",
                style: TextStyle(
                  fontSize: 40,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 40, 0, 40),
              child: CircularIconButton(
                icon: Icons.logout,
                onPressed: () {
                  _logout();
                },
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: _loggingOut
                    ? CircularProgressIndicator()
                    : SizedBox.shrink(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _logout() {
    setState(() {
      _loggingOut = true;
    });
    Model.sharedInstance.logOut().then((result) {
      setState(() {
        _loggingOut = false;
        userLogged = "";
      });
      Navigator.of(context).pop();
      Navigator.of(context).push(
        PageRouteBuilder(
          opaque: false,
          transitionDuration: Duration(milliseconds: 800),
          pageBuilder: (BuildContext context, _, __) =>
              Layout(page: UserLogin()),
        ),
      );
    });
  }
}
