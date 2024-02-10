import 'package:grey_note/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:grey_note/pages/todos.dart';

class NavigationProvider extends ChangeNotifier {
  Widget? currentPage;
  int currentIndex = 0;

  // void notesTabClicked() {
  //   currentPage = const Home();
  //   notifyListeners();
  // }
  //
  // void todosTabClicked() {
  //   currentPage = const Todos();
  //   notifyListeners();
  // }

  void changeDestination(int index) {
    currentIndex = index;
    (currentIndex == 0)
        ? currentPage = const Home()
        : currentPage = const Todos();
    notifyListeners();
  }
}
