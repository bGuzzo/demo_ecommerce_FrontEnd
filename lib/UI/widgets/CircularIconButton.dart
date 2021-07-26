import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CircularIconButton extends StatelessWidget {
  final IconData icon;
  final Function onPressed;
  double dimension = 15;

  CircularIconButton({Key key, this.icon, this.onPressed, this.dimension})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(5),
        child: RawMaterialButton(
          onPressed: onPressed,
          elevation: 2.0,
          fillColor: Theme.of(context).primaryColor,
          child: Icon(icon, color: Theme.of(context).backgroundColor),
          padding: EdgeInsets.all(dimension != null ? dimension : 15.0),
          shape: CircleBorder(),
        ));
  }
}
