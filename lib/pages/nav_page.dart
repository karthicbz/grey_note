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
    return Scaffold(
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: currentWidget,
        ),
        bottomNavigationBar: GNav(
            gap: 8.0,
            backgroundColor: Color(
                int.parse(context.watch<SettingsProvider>().homeCardsColor)),
            tabs: [
              GButton(
                icon: Icons.notes,
                text: 'Notes',
                haptic: true,
                padding: const EdgeInsets.only(
                  left: 90.0,
                  right: 90.0,
                  bottom: 16.0,
                  top: 16.0,
                ),
                onPressed: () =>
                    context.read<NavigationProvider>().notesTabClicked(),
              ),
              GButton(
                icon: Icons.done,
                text: 'Todos',
                haptic: true,
                padding: const EdgeInsets.only(
                  right: 90.0,
                  left: 90.0,
                  bottom: 16.0,
                  top: 16.0,
                ),
                onPressed: () =>
                    context.read<NavigationProvider>().todosTabClicked(),
              )
            ]));
  }
}
