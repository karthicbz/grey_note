import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class NoteModel {
  final String? _title;
  final String? _note;
  final String? _dateTime;
  bool? _isLongPressed;

  NoteModel(
      {String? title, String? note, String? dateTime, bool? isLongPressed})
      : _title = title,
        _note = note,
        _dateTime = dateTime,
        _isLongPressed = isLongPressed;

  get title {
    return _title;
  }

  get note {
    return _note;
  }

  get dateTime {
    return _dateTime;
  }

  bool get isLongPressed {
    return _isLongPressed!;
  }

  set isLongPressed(bool val) {
    _isLongPressed = val;
  }

  Future<void> saveNote() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString('grey_note') != null) {
      List<dynamic> data = jsonDecode(pref.getString('grey_note') ?? '');
      data.add({
        _title: [_note, _dateTime]
      });
      pref.setString('grey_note', jsonEncode(data));
    } else {
      pref.setString(
          'grey_note',
          jsonEncode([
            {
              _title: [_note, _dateTime]
            }
          ]));
    }
  }

  Future<List<dynamic>> getAllNotes() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString('grey_note') != null) {
      List<dynamic> data = jsonDecode(pref.getString('grey_note') ?? '');
      return data;
    } else {
      return [];
    }
  }
}
