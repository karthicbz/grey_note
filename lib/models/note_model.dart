import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class NoteModel {
  final String? _title;
  final String? _note;

  NoteModel({String? title, String? note})
      : _title = title,
        _note = note;

  Future<void> saveNote() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString('grey_note') != null) {
      List<dynamic> data = jsonDecode(pref.getString('grey_note') ?? '');
      data.add({_title: _note});
      pref.setString('grey_note', jsonEncode(data));
    } else {
      pref.setString(
          'grey_note',
          jsonEncode([
            {_title: _note}
          ]));
    }
  }
}
