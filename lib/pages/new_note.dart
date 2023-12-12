import 'package:flutter/material.dart';
import 'package:grey_note/models/note_model.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Note"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
        child: Flex(direction: Axis.vertical, children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(hintText: "Title.."),
          ),
          const SizedBox(
            height: 20.0,
          ),
          TextFormField(
            controller: noteController,
            keyboardType: TextInputType.multiline,
            maxLines: null,
          ),
          const SizedBox(
            height: 20.0,
          ),
          OutlinedButton.icon(
              onPressed: () async {
                NoteModel nm = NoteModel(
                    title: titleController.text,
                    note: noteController.text,
                    dateTime: DateTime.now().toString().split('.')[0]);
                await nm.saveNote();
                if (!context.mounted) return;
                Navigator.pop(context);
              },
              icon: const Icon(Icons.save),
              label: const Text('Save'))
        ]),
      ),
    );
  }
}
