import 'package:FrontEnd/UI/behaviors/AppLocalizations.dart';
import 'package:FrontEnd/UI/widgets/OrderCard.dart';
import 'package:FrontEnd/model/Model.dart';
import 'package:FrontEnd/model/objects/Acquisto.dart';
import 'package:FrontEnd/model/support/extensions/StringCapitalization.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  Orders({Key key}) : super(key: key);

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Acquisto> _ordini;
  bool _searching = true;

  @override
  Widget build(BuildContext context) {
    if (_searching) {
      _ordini = null;
      Model.sharedInstance.getOrdini().then((value) {
        setState(() {
          _ordini = value;
          _searching = false;
        });
      });
    }
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Column(
          children: [
            top(),
            bottom(),
          ],
        ),
      ),
    );
  }

  Widget top() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                AppLocalizations.of(context)
                    .translate("your_orders")
                    .capitalize,
                style: TextStyle(
                  fontSize: 30,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bottom() {
    return !_searching
        ? _ordini == null
            ? SizedBox.shrink()
            : _ordini.length == 0
                ? noResult()
                : yesResults()
        : CircularProgressIndicator();
  }

  Widget noResult() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(AppLocalizations.of(context).translate("no_orders").capitalize,
            style:
                TextStyle(color: Theme.of(context).errorColor, fontSize: 30)),
      ],
    );
  }

  Widget yesResults() {
    return Expanded(
      child: Container(
        child: ListView.builder(
          itemCount: _ordini.length,
          itemBuilder: (context, index) {
            return Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: AcquistoCard(
                            acquisto: _ordini[index],
                          ),
                        ),
                      ],
                    ),
                  ],
                ));
          },
        ),
      ),
    );
  }
}
