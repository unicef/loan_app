import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String text;
  final String buttontext;
  final Function onTap;
  final bool status;
  final bool isImage;

  CustomAlertDialog({
    @required this.title,
    @required this.text,
    @required this.onTap,
    this.buttontext,
    this.status = false,
    this.isImage = false,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            status ? MdiIcons.check : MdiIcons.closeCircle,
            size: 50,
            color: status
                ? Theme.of(context).primaryColor
                : Theme.of(context).errorColor,
          ),
          SizedBox(height: 10),
          Text(text),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: onTap,
          child: Text(buttontext ?? 'Okay'),
        )
      ],
    );
  }
}