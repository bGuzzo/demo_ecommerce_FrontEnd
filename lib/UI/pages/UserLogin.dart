import 'package:FrontEnd/UI/behaviors/AppLocalizations.dart';
import 'package:FrontEnd/UI/pages/UserRegistration.dart';
import 'package:FrontEnd/UI/widgets/CircularIconButton.dart';
import 'package:FrontEnd/UI/widgets/InputField.dart';
import 'package:FrontEnd/model/Model.dart';
import 'package:FrontEnd/model/support/LogInResult.dart';
import 'package:FrontEnd/model/support/extensions/StringCapitalization.dart';
import 'package:flutter/material.dart';

import 'Layout.dart';
import 'UserLogout.dart';

class UserLogin extends StatefulWidget {
  UserLogin({Key key}) : super(key: key);

  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _logging = false;
  LogInResult _justLogged;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 40, 0, 10),
              child: Text(
                AppLocalizations.of(context).translate("login").capitalize +
                    "!",
                style: TextStyle(
                  fontSize: 40,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Column(
                children: [
                  Container(
                    width: (60*MediaQuery.of(context).size.width)/100,
                    child: InputField(
                      labelText: AppLocalizations.of(context)
                          .translate("email")
                          .capitalize +
                          " o " +
                          AppLocalizations.of(context)
                              .translate("username")
                              .capitalize,
                      controller: _emailController,
                    ),
                  ),
                  Container(
                    width: (60*MediaQuery.of(context).size.width)/100,
                    child: InputField(
                      labelText: AppLocalizations.of(context)
                          .translate("password")
                          .capitalize,
                      controller: _passwordController,
                      isPassword: true,
                    ),
                  ),
                  CircularIconButton(
                    icon: Icons.login,
                    onPressed: () {
                      _login();
                    },
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: _logging
                          ? CircularProgressIndicator()
                          : _justLogged != null
                              ? _justLogged ==
                                      LogInResult.error_wrong_credentials
                                  ? Text(
                                      AppLocalizations.of(context)
                                          .translate("wrong_cr")
                                          .capitalize,
                                      style: TextStyle(
                                        color: Theme.of(context).errorColor,
                                        fontSize: 20,
                                      ),
                                    )
                                  : _justLogged == LogInResult.logged
                                      ? SizedBox.shrink()
                                      : Text(AppLocalizations.of(context)
                                          .translate("u_error")
                                          .capitalize)
                              : SizedBox.shrink(),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 50, 0, 10),
              child: TextButton(
                child: Text(
                  AppLocalizations.of(context)
                      .translate("no_account")
                      .capitalize,
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                onPressed: () {
                  _registration();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void _login() {
    setState(() {
      _logging = true;
      _justLogged = null;
    });
    Model.sharedInstance
        .logIn(_emailController.text, _passwordController.text)
        .then((result) {
      setState(() {
        _logging = false;
        _justLogged = result;
      });
      if (_justLogged == LogInResult.logged) {
        // se l'utente è riuscito a loggarsi
        Navigator.of(context).pop();
        Navigator.of(context).push(
          PageRouteBuilder(
            opaque: false,
            transitionDuration: Duration(milliseconds: 800),
            pageBuilder: (BuildContext context, _, __) =>
                Layout(page: UserLogout(userLogged: _emailController.text)),
          ),
        );
      }
    });
  }

  void _registration() {
    Navigator.of(context).pop();
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        transitionDuration: Duration(milliseconds: 800),
        pageBuilder: (BuildContext context, _, __) =>
            Layout(page: UserRegistration()),
      ),
    );
  }
}
