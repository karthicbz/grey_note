import 'package:grey_note/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:grey_note/pages/todos.dart';

class NavigationProvider extends ChangeNotifier {
  Widget? currentPage;

  void notesTabClicked() {
    currentPage = const Home();
    notifyListeners();
  }

  void todosTabClicked() {
    currentPage = const Todos();
    notifyListeners();
  }
}
