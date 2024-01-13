import 'package:flutter/cupertino.dart';

class SettingsProvider extends ChangeNotifier {
  bool dark = false;

  void enableDarkTheme() {
    dark = !dark;
    notifyListeners();
  }
}
