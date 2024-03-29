import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

class NoteModel {
  final String? _title;
  final String? _note;
  final String? _dateTime;
  final String? _uuid;
  bool? _isLongPressed;

  NoteModel(
      {String? title,
      String? note,
      String? dateTime,
      String? uuid,
      bool? isLongPressed})
      : _title = title,
        _note = note,
        _dateTime = dateTime,
        _uuid = uuid,
        _isLongPressed = isLongPressed;

  get title {
    return _title;
  }

  get note {
    return _note;
  }

  get uuid {
    return _uuid;
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
    var box = Hive.box('grey_notes');
    // SharedPreferences pref = await SharedPreferences.getInstance();
    if (box.get('notes') != null) {
      List<dynamic> data = jsonDecode(box.get('notes') ?? '');
      data.add({
        _title: [_note, _uuid, _dateTime]
      });
      box.put('notes', jsonEncode(data));
    } else {
      box.put(
          'notes',
          jsonEncode([
            {
              _title: [_note, _uuid, _dateTime]
            }
          ]));
    }
  }

  Future<List<dynamic>> getAllNotes() async {
    var box = Hive.box('grey_notes');
    // print(box.get('grey_notes'));
    // SharedPreferences pref = await SharedPreferences.getInstance();
    if (box.get('notes') != null) {
      List<dynamic> data = jsonDecode(box.get('notes') ?? '');
      print(data);
      return data;
    } else {
      return [];
    }
  }
}
