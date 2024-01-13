import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  bool dark = false;

  SettingsProvider() {
    initializeSettings();
  }

  void initializeSettings() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString('settings') != null) {
      Map<String, dynamic> data = jsonDecode(pref.getString('settings') ?? '');
      dark = data['theme'];
      notifyListeners();
    } else {
      dark = false;
    }
  }

  void enableDarkTheme() async {
    dark = !dark;
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString('settings') != null) {
      Map<String, dynamic> data = jsonDecode(pref.getString('settings') ?? '');
      data['theme'] = dark;
      pref.setString('settings', jsonEncode(data));
    }else{
      pref.setString('settings', jsonEncode({'theme':dark}));
    }
    notifyListeners();
  }
}
