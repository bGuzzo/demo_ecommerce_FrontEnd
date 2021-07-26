import 'package:avatar_view/avatar_view.dart';
import 'package:FrontEnd/UI/behaviors/AppLocalizations.dart';
import 'package:FrontEnd/UI/pages/Layout.dart';
import 'package:FrontEnd/UI/pages/ShoppingCart.dart';
import 'package:FrontEnd/UI/pages/ShoppingCartNo.dart';
import 'package:FrontEnd/UI/widgets/CircularIconButton.dart';
import 'package:FrontEnd/model/Model.dart';
import 'package:FrontEnd/model/objects/Product.dart';
import 'package:FrontEnd/model/support/extensions/StringCapitalization.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  Product product;

  ProductCard({Key key, this.product}) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState(product);
}

class _ProductCardState extends State<ProductCard> {
  int _quantity = 1;
  Product product;

  _ProductCardState(Product product) {
    this.product = product;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: AvatarView(
                  radius: 60,
                  borderColor: Theme.of(context).primaryColor,
                  avatarType: AvatarType.RECTANGLE,
                  backgroundColor: Theme.of(context).backgroundColor,
                  imagePath: "images/" + product.id.toString() + ".jpg",
                  placeHolder: Container(
                    child: Icon(
                      Icons.image,
                      size: 50,
                    ),
                  ),
                  errorWidget: Container(
                    child: Icon(
                      Icons.error,
                      size: 50,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 15),
                          child: Text(
                            product.name,
                            style: TextStyle(
                              fontSize: 30,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: RawMaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          onPressed: () {
                            _showDetails();
                          },
                          elevation: 5,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate("details_ProductCard")
                                  .capitalize,
                              style: TextStyle(
                                  color: Theme.of(context).backgroundColor),
                            ),
                          ),
                          fillColor: Theme.of(context).primaryColor,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      AppLocalizations.of(context)
                          .translate("price")
                          .capitalize,
                      style: TextStyle(
                        fontSize: 30,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Text(
                      product.price.toString() + " €",
                      style: TextStyle(
                        fontSize: 30,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                      flex: 0,
                      child: Text(
                        AppLocalizations.of(context)
                            .translate("quantity")
                            .capitalize,
                        style: TextStyle(
                          fontSize: 30,
                          color: product.quantity > 0
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).errorColor,
                        ),
                      )),
                  Flexible(
                      flex: 0,
                      child: Text(
                        product.quantity.toString(),
                        style: TextStyle(
                          fontSize: 30,
                          color: product.quantity > 0
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).errorColor,
                        ),
                      ))
                ],
              )),
              Column(
                children: [
                  Row(
                    children: [
                      CircularIconButton(
                        icon: Icons.add,
                        dimension: 7,
                        onPressed: () {
                          _incrementQuantity();
                        },
                      ),
                      Text(
                        _quantity.toString(),
                        style: TextStyle(
                          fontSize: 20,
                          color: product.quantity > 0
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).errorColor,
                        ),
                      ),
                      CircularIconButton(
                        icon: Icons.remove,
                        dimension: 7,
                        onPressed: () {
                          _dcrementQuantity();
                        },
                      )
                    ],
                  ),
                  RawMaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    onPressed: () {
                      _inserisciNelCarrello();
                    },
                    elevation: 2.0,
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Text(
                            AppLocalizations.of(context)
                                .translate("add_shopping_cart")
                                .capitalize,
                            style: TextStyle(
                              color: Theme.of(context).backgroundColor,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: Icon(Icons.add_shopping_cart,
                              color: Theme.of(context).backgroundColor),
                        )
                      ],
                    ),
                    fillColor: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ],
          )),
    );
  }

  void _dcrementQuantity() {
    setState(() {
      if (_quantity > 1) _quantity--;
    });
  }

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _showDetails() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(
          AppLocalizations.of(context).translate("description").capitalize,
          style: TextStyle(
            fontSize: 20,
            color: Theme.of(context).primaryColor,
          ),
        ),
        content: Text(
          product.description,
          style: TextStyle(
            fontSize: 15,
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
            },
          )
        ],
      ),
    );
  }

  void _inserisciNelCarrello() {
    if (Model.sharedInstance.logged == false) {
      Navigator.of(context).pop();
      Navigator.of(context).push(
        PageRouteBuilder(
          opaque: false,
          transitionDuration: Duration(milliseconds: 800),
          pageBuilder: (BuildContext context, _, __) =>
              Layout(page: ShoppingCartNo()),
        ),
      );
    } else {
      int qtaVecchia = 0;
      setState(() {
        Model.sharedInstance.getProdotti2().then((value) {
          if (value.containsKey(product)) qtaVecchia = value[product];
          print("ProductCard getProdotti2() = " + value.toString());
          print("product" + product.toString());
          print("qtaVecchia" + qtaVecchia.toString());
          setState(() {
            Model.sharedInstance.aggiornaCarrello(
                Model.sharedInstance.userLogged,
                product.id.toString(),
                (_quantity + qtaVecchia).toString());
          });
          Navigator.of(context).pop();
          Navigator.of(context).push(
            PageRouteBuilder(
              opaque: false,
              transitionDuration: Duration(milliseconds: 800),
              pageBuilder: (BuildContext context, _, __) =>
                  Layout(page: ShoppingCart()),
            ),
          );
        });
      });
    }
  }
}
