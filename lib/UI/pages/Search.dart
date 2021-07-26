import 'package:FrontEnd/UI/behaviors/AppLocalizations.dart';
import 'package:FrontEnd/UI/widgets/CircularIconButton.dart';
import 'package:FrontEnd/UI/widgets/InputField.dart';
import 'package:FrontEnd/UI/widgets/ProductCard.dart';
import 'package:FrontEnd/model/Model.dart';
import 'package:FrontEnd/model/objects/Product.dart';
import 'package:FrontEnd/model/support/extensions/StringCapitalization.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  Search({Key key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool _searching = false;
  List<Product> _products;
  int _selectedDropItem;

  TextEditingController _searchFiledController = TextEditingController();
  TextEditingController _maxPriceFieldController = TextEditingController();
  TextEditingController _minPriceFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Column(
        children: [
          Row(
            //RIGA DI RICERCA NORMALE
            children: [
              Flexible(
                child: InputField(
                  labelText: AppLocalizations.of(context)
                      .translate("search")
                      .capitalize,
                  controller: _searchFiledController,
                  onSubmit: (value) {
                    _search();
                  },
                ),
              ),
              CircularIconButton(
                icon: Icons.search_rounded,
                onPressed: () {
                  _search();
                },
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(25),
            child: Row(
              // RIGA DI RICERCA AVANZATA
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    AppLocalizations.of(context)
                            .translate("adv_research")
                            .capitalize +
                        ": ",
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                Flexible(
                  child: InputField(
                    labelText: AppLocalizations.of(context)
                        .translate("min_price")
                        .capitalize,
                    controller: _minPriceFieldController,
                  ),
                ),
                Flexible(
                  child: InputField(
                    labelText: AppLocalizations.of(context)
                        .translate("max_price")
                        .capitalize,
                    controller: _maxPriceFieldController,
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: DropdownButton(
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).primaryColor,
                      ),
                      isExpanded: true,
                      items: [
                        DropdownMenuItem(
                          child: Text(AppLocalizations.of(context)
                              .translate("all")
                              .capitalize),
                          value: 0,
                        ),
                        DropdownMenuItem(
                          child: Text(AppLocalizations.of(context)
                              .translate("road_bike")
                              .capitalize),
                          value: 1,
                        ),
                        DropdownMenuItem(
                          child: Text(AppLocalizations.of(context)
                              .translate("mtb")
                              .capitalize),
                          value: 2,
                        ),
                        DropdownMenuItem(
                          child: Text(AppLocalizations.of(context)
                              .translate("clothes")
                              .capitalize),
                          value: 3,
                        ),
                        DropdownMenuItem(
                          child: Text(AppLocalizations.of(context)
                              .translate("tools")
                              .capitalize),
                          value: 4,
                        ),
                        DropdownMenuItem(
                          child: Text(AppLocalizations.of(context)
                              .translate("tire")
                              .capitalize),
                          value: 5,
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedDropItem = value;
                        });
                      },
                      hint: Text(
                        AppLocalizations.of(context)
                            .translate("sel_cat")
                            .capitalize,
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      value: _selectedDropItem,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget bottom() {
    return !_searching
        ? _products == null
            ? SizedBox.shrink()
            : _products.length == 0
                ? noResults()
                : yesResults()
        : CircularProgressIndicator();
  }

  Widget noResults() {
    return Text(
      AppLocalizations.of(context).translate("no_results").capitalize + "!",
      style: TextStyle(color: Theme.of(context).errorColor, fontSize: 17),
    );
  }

  Widget yesResults() {
    return Expanded(
      child: Container(
        child: ListView.builder(
          itemCount: _products.length,
          itemBuilder: (context, index) {
            return ProductCard(
              product: _products[index],
            );
          },
        ),
      ),
    );
  }

  void _search() {
    setState(() {
      _searching = true;
      _products = null;
    });
    Model.sharedInstance
        .searchProductNameDescription(
            _searchFiledController.text,
            _minPriceFieldController.text,
            _maxPriceFieldController.text,
            _selectedDropItem)
        .then((result) {
      setState(() {
        _searching = false;
        _products = result;
      });
    });
  }

  void _openAdvancedResearch() {
    showDialog(
        context: context,
        builder: (BuildContext context) => SimpleDialog(
              title: Text(
                AppLocalizations.of(context)
                    .translate("adv_research")
                    .capitalize,
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(25),
                      child: Row(
                        children: [
                          Text(
                            "Prezzo minimo: ", //TODO tradurre
                            style: TextStyle(
                              fontSize: 15,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          Flexible(
                            child: TextField(
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(25, 0, 25, 25),
                      child: Row(
                        children: [
                          Text(
                            "Prezzo massimo: ", //TODO tradurre
                            style: TextStyle(
                              fontSize: 15,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          Flexible(
                            child: TextField(
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(25, 0, 25, 25),
                      child: Row(
                        children: [
                          Text(
                            "categoria : ", //TODO tradurre
                            style: TextStyle(
                              fontSize: 15,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          //InputField(),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ));
  }
}
