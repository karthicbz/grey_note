import 'package:flutter/material.dart';
import 'package:grey_note/pages/home.dart';
import 'package:grey_note/pages/new_note.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(useMaterial3: true),
      theme: ThemeData.light(useMaterial3: true),
      home: const Home(),
      routes: {
        "/new-note": (context) => const NewNote(),
      },
    );
  }
}
