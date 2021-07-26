import 'package:avatar_view/avatar_view.dart';
import 'package:FrontEnd/UI/behaviors/AppLocalizations.dart';
import 'package:FrontEnd/UI/pages/Layout.dart';
import 'package:FrontEnd/UI/pages/ShoppingCart.dart';
import 'package:FrontEnd/UI/widgets/CircularIconButton.dart';
import 'package:FrontEnd/model/Model.dart';
import 'package:FrontEnd/model/objects/Product.dart';
import 'package:FrontEnd/model/support/extensions/StringCapitalization.dart';
import 'package:flutter/material.dart';

class ProductCardShoppingCart extends StatefulWidget {
  Product product;
  int quantity;

  ProductCardShoppingCart({Key key, this.product, this.quantity})
      : super(key: key);

  @override
  _ProductCardShoppingCartState createState() =>
      _ProductCardShoppingCartState(product, quantity);
}

class _ProductCardShoppingCartState extends State<ProductCardShoppingCart> {
  int quantity = 0;
  Product product;

  _ProductCardShoppingCartState(Product product, int quantity) {
    this.product = product;
    this.quantity = quantity;
    /*
    Model.sharedInstance.getQuantita(product.id).then((value) {
      setState(() {
        quantity=value;
      });
    });*/
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
                                  .translate("details")
                                  .capitalize,
                              style: TextStyle(
                                  color: Theme.of(context).backgroundColor),
                            ),
                          ),
                          fillColor: Theme.of(context).primaryColor,
                        )),
                  ],
                ),
              )),
              Expanded(
                child: Column(
                  //Colonna Prezzo
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
                      (product.price * quantity).toString() + "€",
                      style: TextStyle(
                        fontSize: 30,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                //Colonna Quantità
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
                        quantity.toString(),
                        style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).primaryColor),
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
                      _rimuoviDalCarrello();
                    },
                    elevation: 2.0,
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Text(
                            AppLocalizations.of(context)
                                .translate("delete")
                                .capitalize,
                            style: TextStyle(
                              color: Theme.of(context).backgroundColor,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: Icon(Icons.delete_outline,
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
      if (quantity > 1) {
        quantity--;
        Model.sharedInstance.aggiornaCarrello(Model.sharedInstance.userLogged,
            product.id.toString(), quantity.toString());
      }
    });
  }

  void _incrementQuantity() {
    setState(() {
      quantity++;
      Model.sharedInstance.aggiornaCarrello(Model.sharedInstance.userLogged,
          product.id.toString(), quantity.toString());
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

  void _rimuoviDalCarrello() {
    Model.sharedInstance.aggiornaCarrello(
        Model.sharedInstance.userLogged, product.id.toString(), "0");
    Navigator.of(context).pop();
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        transitionDuration: Duration(milliseconds: 800),
        pageBuilder: (BuildContext context, _, __) =>
            Layout(page: ShoppingCart()),
      ),
    );
  }
}
