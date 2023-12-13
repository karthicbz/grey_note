import 'package:flutter/material.dart';
import 'package:grey_note/models/note_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<NoteModel> allNotes = [];
  NoteModel nm = NoteModel();
  // bool longPressed = false;

  Future<void> loadAllNotes() async {
    final data = await nm.getAllNotes();
    for (var d in data) {
      NoteModel nm = NoteModel(
          title: d.keys.first,
          note: d.values.first[0],
          dateTime: d.values.first[1],
          isLongPressed: false);
      setState(() {
        allNotes.add(nm);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadAllNotes();
  }

  bool isSyncing = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grey Notes'),
      ),
      body: ListView.builder(
          itemCount: allNotes.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: Card(
                child: ListTile(
                  leading: Text(
                    (index + 1).toString(),
                    style: const TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.w400),
                  ),
                  title: allNotes[index].isLongPressed
                      ? Row(
                          children: [
                            ElevatedButton(
                                onPressed: () {}, child: const Text('Delete')),
                            const SizedBox(
                              width: 10.0,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    allNotes[index].isLongPressed = false;
                                  });
                                },
                                child: const Text('Cancel'))
                          ],
                        )
                      : Text(
                          allNotes[index].title,
                          style: const TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w400),
                        ),
                  subtitle: allNotes[index].isLongPressed
                      ? Container()
                      : Text('Created on: ${allNotes[index].dateTime}'),
                  onLongPress: () {
                    // print(allNotes[index].isLongPressed);
                    setState(() {
                      allNotes[index].isLongPressed = true;
                    });
                  },
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/new-note');
          allNotes = [];
          setState(() {
            loadAllNotes();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
