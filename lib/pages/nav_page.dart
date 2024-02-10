import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:grey_note/pages/home.dart';
import 'package:grey_note/pages/new_note.dart';
import 'package:grey_note/pages/todos.dart';
import 'package:grey_note/providers/nav_provider.dart';
import 'package:grey_note/providers/settings_provider.dart';
import 'package:provider/provider.dart';

class NavPage extends StatelessWidget {
  const NavPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget currentWidget =
        context.watch<NavigationProvider>().currentPage ?? const Home();
    int currentIndex = context.watch<NavigationProvider>().currentIndex;
    String navigationBackground =
        context.watch<SettingsProvider>().homeCardsColor;
    return Scaffold(
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: currentWidget,
        ),
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            context.read<NavigationProvider>().changeDestination(index);
          },
          backgroundColor: Color(int.parse(navigationBackground)),
          indicatorColor: Colors.white,
          selectedIndex: currentIndex,
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.notes),
              label: 'Notes',
              selectedIcon: Icon(
                Icons.notes,
                color: Color(int.parse(navigationBackground)),
              ),
            ),
            NavigationDestination(
              icon: const Icon(Icons.check_box_outlined),
              label: 'Notes',
              selectedIcon: Icon(
                Icons.check_box_outlined,
                color: Color(int.parse(navigationBackground)),
              ),
            ),
          ],
        ));
  }
}
