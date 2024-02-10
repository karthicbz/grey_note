import 'package:flutter/material.dart';

class CustomListTile {
  String? leadingText;
  String? titleText;
  String? trailingText;
  String? splashColor;
  Color? textColor;

  CustomListTile(
      {this.leadingText,
      this.titleText,
      this.trailingText,
      this.splashColor,
      this.textColor});

  Widget listTile({Function? onTapFunction}) {
    return ListTile(
      title: Text(
        titleText ?? '',
        textAlign: TextAlign.start,
        style: TextStyle(
          color: textColor,
          fontSize: 20.0,
        ),
      ),
      trailing: Text(
        'Not Complete',
        style: TextStyle(
          color: textColor,
        ),
      ),
      onTap: (){},
      splashColor: Color(int.parse(splashColor ?? '0xff00BFA5')),
    );
  }
}
