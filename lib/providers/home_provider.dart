import 'package:flutter/foundation.dart';
import 'package:grey_note/models/note_model.dart';

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

  void isCancelPressed(String uuid){
    for (var note in allNotes) {
      if (note.uuid == uuid) {
        note.isLongPressed = false;
        notifyListeners();
      }
    }
  }

  void initializeHomeCards() async {
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
