import 'package:flutter/material.dart';
import 'package:grey_note/models/note_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic> allNotes = [];
  NoteModel nm = NoteModel();

  Future<void> loadAllNotes() async {
    final data = await nm.getAllNotes();
    for (var d in data) {
      setState(() {
        allNotes.add(d);
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
                  title: Text(
                    allNotes[index].keys.first,
                    style: const TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.w400),
                  ),
                  subtitle:
                      Text('Created on: ${allNotes[index].values.first[1]}'),
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
