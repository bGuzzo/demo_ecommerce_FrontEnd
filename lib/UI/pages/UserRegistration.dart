import 'dart:html';

import 'package:FrontEnd/UI/behaviors/AppLocalizations.dart';
import 'package:FrontEnd/UI/pages/UserLogin.dart';
import 'package:FrontEnd/UI/widgets/CircularIconButton.dart';
import 'package:FrontEnd/UI/widgets/InputField.dart';
import 'package:FrontEnd/model/Model.dart';
import 'package:FrontEnd/model/objects/User.dart';
import 'package:FrontEnd/model/support/RegistrationResult.dart';
import 'package:FrontEnd/model/support/extensions/StringCapitalization.dart';
import 'package:flutter/material.dart';

import 'Layout.dart';

class UserRegistration extends StatefulWidget {
  UserRegistration({Key key}) : super(key: key);

  @override
  _UserRegistrationState createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  bool _adding = false;
  RegistrationResult _registrationResult;
  bool _errorPassword = false;
  bool _emptyField = false;

  TextEditingController _firstNameFiledController = TextEditingController();
  TextEditingController _lastNameFiledController = TextEditingController();
  TextEditingController _usernameFiledController = TextEditingController();
  TextEditingController _passwordFiledController = TextEditingController();
  TextEditingController _telephoneNumberFiledController =
      TextEditingController();
  TextEditingController _emailFiledController = TextEditingController();
  TextEditingController _addressFiledController = TextEditingController();

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
                AppLocalizations.of(context).translate("register").capitalize +
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
                  InputField(
                    labelText: AppLocalizations.of(context)
                            .translate("firstName")
                            .capitalize +
                        "*".capitalize,
                    controller: _firstNameFiledController,
                  ),
                  InputField(
                    labelText: AppLocalizations.of(context)
                            .translate("lastName")
                            .capitalize +
                        "*".capitalize,
                    controller: _lastNameFiledController,
                  ),
                  InputField(
                    labelText: AppLocalizations.of(context)
                            .translate("username")
                            .capitalize +
                        "*".capitalize,
                    controller: _usernameFiledController,
                  ),
                  InputField(
                    labelText: AppLocalizations.of(context)
                            .translate("password")
                            .capitalize +
                        "*".capitalize,
                    controller: _passwordFiledController,
                    isPassword: true,
                  ),
                  InputField(
                    labelText: AppLocalizations.of(context)
                        .translate("telephoneNumber")
                        .capitalize,
                    controller: _telephoneNumberFiledController,
                  ),
                  InputField(
                    labelText: AppLocalizations.of(context)
                            .translate("email")
                            .capitalize +
                        "*".capitalize,
                    controller: _emailFiledController,
                  ),
                  InputField(
                    labelText: AppLocalizations.of(context)
                        .translate("address")
                        .capitalize,
                    controller: _addressFiledController,
                  ),
                  CircularIconButton(
                    icon: Icons.person_add,
                    onPressed: () {
                      print("_emptyField " + _emptyField.toString());
                      print("_justAddedUser " + _registrationResult.toString());
                      _register();
                    },
                  ),
                  Center(
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: _adding
                            ? CircularProgressIndicator()
                            : _registrationResult ==
                                    RegistrationResult.registered
                                ? Text(AppLocalizations.of(context).translate("just_added").capitalize + "!",
                                    style: TextStyle(
                                        color: Colors.green, fontSize: 17))
                                : _emptyField
                                    ? Text(AppLocalizations.of(context).translate("field_err").capitalize,
                                        style: TextStyle(
                                            color: Theme.of(context).errorColor,
                                            fontSize: 17))
                                    : _errorPassword
                                        ? Text(AppLocalizations.of(context).translate("password_err").capitalize,
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .errorColor,
                                                fontSize: 17))
                                        : _registrationResult ==
                                                RegistrationResult
                                                    .error_username_already_used
                                            ? Text(AppLocalizations.of(context).translate("username_err").capitalize,
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .errorColor,
                                                    fontSize: 17))
                                            : _registrationResult ==
                                                    RegistrationResult
                                                        .error_email_already_used
                                                ? Text(
                                                    AppLocalizations.of(context)
                                                        .translate("email_err")
                                                        .capitalize,
                                                    style: TextStyle(
                                                        color: Theme.of(context).errorColor,
                                                        fontSize: 17))
                                                : _registrationResult == RegistrationResult.error_unknown
                                                    ? Text(AppLocalizations.of(context).translate("u_err").capitalize, style: TextStyle(color: Theme.of(context).errorColor, fontSize: 17))
                                                    : SizedBox.shrink()),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 50, 0, 10),
                    child: TextButton(
                      child: Text(
                        AppLocalizations.of(context)
                            .translate("just_reg")
                            .capitalize,
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _register() {
    setState(() {
      _adding = true;
      _registrationResult = null;
      if (emptyField()) {
        _adding = false;
        _emptyField = true;
      } else if (_wrongPassword()) {
        _adding = false;
        _errorPassword = true;
      } else {
        _emptyField = false;
        _errorPassword = false;
      }
    });
    if (_emptyField || _errorPassword) return;
    User user = User(
        firstName: _firstNameFiledController.text,
        lastName: _lastNameFiledController.text,
        telephoneNumber: _telephoneNumberFiledController.text,
        email: _emailFiledController.text,
        address: _addressFiledController.text,
        username: _usernameFiledController.text);
    Map<String, String> params = new Map();
    params["password"] = _passwordFiledController.text;
    Model.sharedInstance.addUser(user, params).then((result) {
      setState(() {
        _adding = false;
        _registrationResult = result;
      });
      if (_registrationResult == RegistrationResult.registered) {
        _login();
      }
    });
  }

  bool _wrongPassword() {
    return _passwordFiledController.text.length < 8 ||
        _passwordFiledController.text.length > 16;
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

  bool emptyField() {
    return _firstNameFiledController.text.isEmpty ||
        _lastNameFiledController.text.isEmpty ||
        _passwordFiledController.text.isEmpty ||
        _usernameFiledController.text.isEmpty;
  }
}
