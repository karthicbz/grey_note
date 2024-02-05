import 'package:flutter/material.dart';
import 'package:grey_note/providers/settings_provider.dart';
import 'package:provider/provider.dart';

class RowSwitch {
  String? switchText;

  RowSwitch({required this.switchText});

  Widget rowSwitch(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            switchText ?? '',
            style: TextStyle(
                fontSize: 18,
                color: context.watch<SettingsProvider>().dark
                    ? Colors.white
                    : Colors.black),
          ),
          Switch(
              value: context.watch<SettingsProvider>().dark,
              activeColor: Color(
                int.parse(context.watch<SettingsProvider>().homeCardsColor),
              ),
              onChanged: (_) {
                context.read<SettingsProvider>().enableDarkTheme();
              })
        ],
      ),
    );
  }
}
