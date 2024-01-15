import 'package:flutter/material.dart';
import 'package:grey_note/models/note_model.dart';
import 'package:grey_note/providers/home_provider.dart';
import 'package:grey_note/providers/settings_provider.dart';
import 'package:provider/provider.dart';

class ViewNote extends StatelessWidget {
  final NoteModel? note;

  ViewNote({super.key, required this.note});

  // ViewNote vn = ViewNote();
  final titleController = TextEditingController();

  final noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // print(widget.note?.title);
    bool isDarkTheme = context.watch<SettingsProvider>().dark;
    titleController.text = note?.title;
    noteController.text = note?.note;
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
          "Edit Note",
          style: TextStyle(color: isDarkTheme ? Colors.white : Colors.black),
        ),
        centerTitle: true,
        actions: [
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 16.0, 0),
              child: TextButton(
                child: Icon(Icons.done,
                    color: isDarkTheme ? Colors.white : Colors.black),
                onPressed: () async {
                  context.read<HomeProvider>().editNote(
                      note?.uuid, titleController.text, noteController.text);
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
              hintText: "Title..",
            ),
            style: TextStyle(
                color: isDarkTheme ? Colors.white : Colors.black,
                fontSize: 18.0),
          ),
          const SizedBox(
            height: 20.0,
          ),
          TextFormField(
            controller: noteController,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: const InputDecoration(
                hintText: 'Your story...', border: InputBorder.none),
            style: TextStyle(
                color: isDarkTheme ? Colors.white : Colors.black,
                fontSize: 18.0),
          ),
          const SizedBox(
            height: 20.0,
          ),
        ]),
      ),
    );
  }
}
