import 'package:FrontEnd/UI/behaviors/AppLocalizations.dart';
import 'package:FrontEnd/UI/pages/Home.dart';
import 'package:FrontEnd/UI/pages/Layout.dart';
import 'package:FrontEnd/UI/widgets/MyDrawer.dart';
import 'package:FrontEnd/model/support/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.APP_NAME,
      supportedLocales: [
        Locale('it', 'IT'),
        Locale('en', 'US'),
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      theme: ThemeData(
        primaryColor: Colors.green[800],
        backgroundColor: Colors.white,
        buttonColor: Colors.lightGreenAccent,
        cardColor: Colors.grey[200],
      ),
      darkTheme: ThemeData(
        primaryColor: Colors.green[800],
        backgroundColor: Colors.grey[900],
        canvasColor: Colors.white,
        buttonColor: Colors.lightGreenAccent,
        cardColor: Colors.grey[800],
      ),
      home: Layout(page: Home(), selected: DrawerItemTypes.HOME),
    );
  }
}
