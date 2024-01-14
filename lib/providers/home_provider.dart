import 'package:flutter/foundation.dart';
import 'package:grey_note/models/note_model.dart';

class HomeProvider extends ChangeNotifier {
  NoteModel nm = NoteModel();
  List<NoteModel> allNotes = [];

  HomeProvider() {
    initializeHomeCards();
  }

  void initializeHomeCards() async {
    final data = await nm.getAllNotes();
    print(data);
    for (var d in data) {
      NoteModel nm = NoteModel(
          title: d.keys.first,
          note: d.values.first[0],
          dateTime: d.values.first[1],
          isLongPressed: false);
      allNotes.add(nm);
      notifyListeners();
    }
  }
}
