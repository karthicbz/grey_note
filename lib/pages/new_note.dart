import 'package:flutter/material.dart';
import 'package:grey_note/models/note_model.dart';
import 'package:grey_note/providers/settings_provider.dart';
import 'package:provider/provider.dart';

class NewNote extends StatefulWidget {
  const NewNote({super.key});

  @override
  State<NewNote> createState() => _NewNoteState();
}

class _NewNoteState extends State<NewNote> {
  final titleController = TextEditingController();
  final noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isDarkTheme = context.watch<SettingsProvider>().dark;
    return Scaffold(
      backgroundColor: isDarkTheme ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isDarkTheme ? Colors.black : Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: isDarkTheme ? Colors.white : Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "New Note",
          style: TextStyle(color: isDarkTheme ? Colors.white : Colors.black),
        ),
        centerTitle: true,
        actions: [
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 16.0, 0),
              child: TextButton(
                child: Icon(
                  Icons.done,
                  color: isDarkTheme ? Colors.white : Colors.black,
                ),
                onPressed: () async {
                  NoteModel nm = NoteModel(
                      title: titleController.text,
                      note: noteController.text,
                      dateTime: DateTime.now().toString().split('.')[0]);
                  await nm.saveNote();
                  if (!context.mounted) return;
                  Navigator.pop(context);
                },
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
        child: Flex(direction: Axis.vertical, children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
                hintText: "Title...", hintStyle: TextStyle(color: Colors.grey)),
            style: TextStyle(color: isDarkTheme?Colors.white:Colors.black),
          ),
          const SizedBox(
            height: 20.0,
          ),
          TextFormField(
            controller: noteController,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: const InputDecoration(
                hintText: 'Your story...',
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.grey)),
            style: TextStyle(color: isDarkTheme?Colors.white:Colors.black),
          ),
          const SizedBox(
            height: 20.0,
          ),
        ]),
      ),
    );
  }
}
