import 'package:flutter/material.dart';
import 'package:grey_note/pages/home.dart';
import 'package:grey_note/pages/new_note.dart';
import 'package:grey_note/pages/settings_page.dart';
import 'package:grey_note/providers/settings_provider.dart';
import 'package:grey_note/widgets/row_switch.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => SettingsProvider())],
      child: MaterialApp(
        darkTheme: ThemeData.dark(useMaterial3: true),
        theme: ThemeData.light(useMaterial3: true),
        home: const Home(),
        routes: {
          "/new-note": (context) => const NewNote(),
          "/settings": (context) => const SettingsPage(),
        },
      ),
    );
  }
}
