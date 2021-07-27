import 'package:FrontEnd/UI/behaviors/AppLocalizations.dart';
import 'package:FrontEnd/UI/widgets/ProductCardShoppingCart.dart';
import 'package:FrontEnd/model/Model.dart';
import 'package:FrontEnd/model/objects/Product.dart';
import 'package:FrontEnd/model/support/extensions/StringCapitalization.dart';
import 'package:flutter/material.dart';

import 'Layout.dart';

class ShoppingCart extends StatefulWidget {
  ShoppingCart({Key key}) : super(key: key);

  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  //List<Product> _prodottiNelCarrello;
  bool _searching = true;
  Map<Product, int> map;
  bool _buying = false;

  @override
  Widget build(BuildContext context) {
    if (_searching) {
      map = null;
      Model.sharedInstance.getProdotti2().then((value) {
        setState(() {
          //print(value);
          map = value;
          _searching = false;
        });
      });
    }
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Column(
          children: [top(), bottom(), medium()],
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
                AppLocalizations.of(context).translate("show_sc").capitalize,
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
        ? map == null
            ? SizedBox.shrink()
            : map.length == 0
                ? noResult()
                : yesResults()
        : CircularProgressIndicator();
  }

  Widget noResult() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Non c'è niente nel carrello",
            style:
                TextStyle(color: Theme.of(context).errorColor, fontSize: 30)),
      ],
    );
  }

  Widget yesResults() {
    return Expanded(
      child: Container(
        child: ListView.builder(
          itemCount: map.length,
          itemBuilder: (context, index) {
            return Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ProductCardShoppingCart(
                            product: List<Product>.from(map.keys)[index],
                            quantity: map[List<Product>.from(map.keys)[index]],
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

  Widget medium() {
    return Align(
      alignment: Alignment.topCenter,
      child: (map != null)
          ? ((map.length != 0)
              ? RawMaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  fillColor: Theme.of(context).primaryColor,
                  elevation: 2.0,
                  onPressed: () {
                    _acquista();
                  },
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(13, 5, 13, 5),
                    child: Text(
                      AppLocalizations.of(context).translate("buy").capitalize,
                      style: TextStyle(
                        fontSize: 30,
                        color: Theme.of(context).backgroundColor,
                      ),
                    ),
                  ))
              : Container())
          : Container(),
    );
  }

  void _acquista() {
    if (map.isEmpty) return;
    setState(() {
      _buying = true;
    });
    Model.sharedInstance
        .acquista(Model.sharedInstance.userLogged, map)
        .then((value) {
      _searching = false;
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          backgroundColor: Theme.of(context).backgroundColor,
          title: Text(
            "Info",
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).primaryColor,
            ),
          ),
          content: Text(
            value.toString(),
            style: TextStyle(
              fontSize: 17,
              color: Theme.of(context).primaryColor,
            ),
          ),
          actions: [
            RawMaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              elevation: 2.0,
              fillColor: Theme.of(context).primaryColor,
              child: Text(
                "OK",
                style: TextStyle(
                  color: Theme.of(context).backgroundColor,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  PageRouteBuilder(
                    opaque: false,
                    transitionDuration: Duration(milliseconds: 800),
                    pageBuilder: (BuildContext context, _, __) =>
                        Layout(page: ShoppingCart()),
                  ),
                );
              },
            )
          ],
        ),
      );
    });
  }
}
