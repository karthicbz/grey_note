import 'package:flutter/material.dart';
import 'package:grey_note/providers/settings_provider.dart';
import 'package:grey_note/widgets/row_switch.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
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
          style: TextStyle(
              color: context.watch<SettingsProvider>().dark
                  ? Colors.white
                  : Colors.black),
        ),
        backgroundColor: context.watch<SettingsProvider>().dark
            ? Colors.black
            : Colors.white,
      ),
      body: Column(
        children: [
          Flexible(
            child: RowSwitch(switchText: 'Dark Theme').rowSwitch(context),
          ),
        ],
      ),
    );
  }
}
