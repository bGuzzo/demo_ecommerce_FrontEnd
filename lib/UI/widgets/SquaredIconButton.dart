import 'package:flutter/material.dart';

class SquaredIconButton extends StatelessWidget {
  final IconData icon;
  final Function onPressed;

  const SquaredIconButton({Key key, this.icon, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      elevation: 0.0,
      fillColor: Theme.of(context).primaryColor,
      child: Icon(icon, color: Theme.of(context).backgroundColor),
      padding: EdgeInsets.all(15.0),
      shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
    );
  }
}
