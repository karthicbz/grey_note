import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:grey_note/models/note_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeProvider extends ChangeNotifier {
  NoteModel nm = NoteModel();
  List<NoteModel> allNotes = [];

  // bool cardLongPressed = false;

  HomeProvider() {
    initializeHomeCards();
  }

  void isCardLongPressed(String uuid) {
    // cardLongPressed = !cardLongPressed;
    for (var note in allNotes) {
      if (note.uuid == uuid) {
        note.isLongPressed = true;
        notifyListeners();
      }
    }
  }

  void isCancelPressed(String uuid) {
    for (var note in allNotes) {
      if (note.uuid == uuid) {
        note.isLongPressed = false;
        notifyListeners();
      }
    }
  }

  void deleteNote(String uuid) async {
    var box = Hive.box('grey_notes');
    // var notes = allNotes.where((note) => note.uuid != uuid);
    final data = await nm.getAllNotes();
    var notes = data.where((d) {
      return d.values.first[1] != uuid;
    });
    // print(notes.toList());
    box.put('notes', jsonEncode(notes.toList()));
    notifyListeners();
  }

  void editNote(String uuid, String currentTitle, String currentNote) async {
    var box = Hive.box('grey_notes');
    final notes = await nm.getAllNotes();
    List<dynamic> noteModel = [];
    for (var note in notes) {
      // print(note.keys);
      if (note.values.first[1] == uuid) {
        // note.keys.first = title;
        // note.values.first[0] = note;
        noteModel.add({
          currentTitle: [
            currentNote,
            note.values.first[1],
            note.values.first[2]
          ]
        });
      } else {
        noteModel.add(note);
      }
    }
    box.put('notes', jsonEncode(noteModel));
    notifyListeners();
  }

  Future<void> initializeHomeCards() async {
    final data = await nm.getAllNotes();
    print(data);
    for (var d in data) {
      NoteModel nm = NoteModel(
          title: d.keys.first,
          note: d.values.first[0],
          uuid: d.values.first[1],
          dateTime: d.values.first[2],
          isLongPressed: false);
      allNotes.add(nm);
      notifyListeners();
    }
  }
}
