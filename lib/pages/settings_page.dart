import 'package:flutter/material.dart';
import 'package:grey_note/providers/settings_provider.dart';
import 'package:grey_note/widgets/row_switch.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    String dropDownValue =
        context.watch<SettingsProvider>().homeCardsColor.toString();
    Color textColor =
        context.watch<SettingsProvider>().dark ? Colors.white : Colors.black;
    return Scaffold(
      backgroundColor:
          context.watch<SettingsProvider>().dark ? Colors.black : Colors.white,
      appBar: AppBar(
        leading: IconButton(
            color: context.watch<SettingsProvider>().dark
                ? Colors.white
                : Colors.black,
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios)),
        title: Text(
          'Settings',
          style: TextStyle(color: textColor),
        ),
        backgroundColor: context.watch<SettingsProvider>().dark
            ? Colors.black
            : Colors.white,
      ),
      body: Column(
        children: [
          RowSwitch(switchText: 'Dark Theme').rowSwitch(context),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Card Color',
                  style: TextStyle(fontSize: 20.0, color: textColor),
                ),
                DropdownButton(
                    value: dropDownValue,
                    items: context
                        .watch<SettingsProvider>()
                        .colors
                        .map((color) => DropdownMenuItem(
                            value: color,
                            child: CircleAvatar(
                              backgroundColor: Color(int.parse(color)),
                              radius: 12,
                            )))
                        .toList(),
                    onChanged: (value) {
                      // print(value);
                      context
                          .read<SettingsProvider>()
                          .changeHomeCardColor(value.toString());
                      // dropDownValue = context.watch<SettingsProvider>().homeCardsColor;
                    })
              ],
            ),
          ),
          SizedBox(
            child: Container(
              height: 1,
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              // horizontal: 8.0,
              vertical: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ListTile(
                  title: Text(
                    'Setup Encryption',
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
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
