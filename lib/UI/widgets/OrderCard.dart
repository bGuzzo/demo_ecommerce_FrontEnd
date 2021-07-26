import 'package:FrontEnd/UI/behaviors/AppLocalizations.dart';
import 'package:FrontEnd/model/Model.dart';
import 'package:FrontEnd/model/objects/Acquisto.dart';
import 'package:FrontEnd/model/support/extensions/StringCapitalization.dart';
import 'package:flutter/material.dart';

class AcquistoCard extends StatefulWidget {
  Acquisto acquisto;

  AcquistoCard({Key key, this.acquisto}) : super(key: key);

  @override
  _AcquistoCardState createState() => _AcquistoCardState(acquisto);
}

class _AcquistoCardState extends State<AcquistoCard> {
  Acquisto acquisto;

  _AcquistoCardState(Acquisto acquisto) {
    this.acquisto = acquisto;
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
              Expanded(
                  child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  //COLONNA ID (Num Ordine)
                  children: [
                    Text(
                      AppLocalizations.of(context)
                          .translate("order_number")
                          .capitalize,
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Text(
                      acquisto.id.toString(),
                      style: TextStyle(
                        fontSize: 30,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              )),
              Column(
                //Colonna dettagli
                children: [
                  Align(
                      alignment: Alignment.center,
                      child: RawMaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        onPressed: () {
                          _dettagli(acquisto.id);
                        },
                        elevation: 2.0,
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate("details")
                                    .capitalize,
                                style: TextStyle(
                                  color: Theme.of(context).backgroundColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        fillColor: Theme.of(context).primaryColor,
                      ))
                ],
              ),
              Expanded(
                  child: Align(
                alignment: Alignment.centerRight,
                child: Column(
                  //Colonna data
                  children: [
                    Text(
                      AppLocalizations.of(context).translate("date").capitalize,
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Text(
                      acquisto.data,
                      style: TextStyle(
                        fontSize: 30,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              )),
            ],
          )),
    );
  }

  void _dettagli(int idOrdine) {
    setState(() {
      Model.sharedInstance.getDettagliOrdine(idOrdine).then((value) {
        print(value);
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
              value,
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
      });
    });
  }
}
