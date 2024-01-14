import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grey_note/pages/home.dart';
import 'package:grey_note/pages/new_note.dart';
import 'package:grey_note/pages/settings_page.dart';
import 'package:grey_note/providers/home_provider.dart';
import 'package:grey_note/providers/settings_provider.dart';
import 'package:grey_note/widgets/row_switch.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDirectory.path);
  await Hive.openBox('grey_notes');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SettingsProvider()),
        ChangeNotifierProvider(create: (context) => HomeProvider()),
      ],
      child: MaterialApp(
        darkTheme: ThemeData.dark(useMaterial3: true),
        theme: ThemeData.light(useMaterial3: true),
        home: Home(),
        routes: {
          "/new-note": (context) => const NewNote(),
          "/settings": (context) => const SettingsPage(),
        },
      ),
    );
  }
}
