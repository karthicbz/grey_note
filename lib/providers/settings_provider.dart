import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SettingsProvider extends ChangeNotifier {
  bool dark = false;
  List<String> colors = ['0xff00BFA5', '0xff00B8D4', '0xff0091EA'];
  String homeCardsColor = '0xff00BFA5';

  SettingsProvider() {
    initializeSettings();
  }

  void initializeSettings() async {
    var box = Hive.box('grey_notes');
    // SharedPreferences pref = await SharedPreferences.getInstance();
    if (box.get('settings') != null) {
      Map<String, dynamic> data = jsonDecode(box.get('settings'));
      dark = data['theme'];
      homeCardsColor = data['homeCardColor'];
      notifyListeners();
    } else {
      dark = false;
      homeCardsColor = '0xff00BFA5';
      // notifyListeners();
    }
  }

  void enableDarkTheme() async {
    dark = !dark;
    var box = Hive.box('grey_notes');
    // SharedPreferences pref = await SharedPreferences.getInstance();
    if (box.get('settings') != null) {
      Map<String, dynamic> data = jsonDecode(box.get('settings'));
      data['theme'] = dark;
      box.put('settings', jsonEncode(data));
    } else {
      box.put('settings', jsonEncode({'theme': dark}));
    }
    notifyListeners();
  }

  void changeHomeCardColor(String color) async {
    homeCardsColor = color;
    // SharedPreferences pref = await SharedPreferences.getInstance();
    var box = Hive.box('grey_notes');
    if (box.get('settings') != null) {
      Map<String, dynamic> data = jsonDecode(box.get('settings'));
      data['homeCardColor'] = color;
      box.put('settings', jsonEncode(data));
    } else {
      box.put('settings', jsonEncode({'homeCardColor': color}));
    }
    notifyListeners();
  }
}
