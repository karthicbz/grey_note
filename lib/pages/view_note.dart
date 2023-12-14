import 'package:flutter/material.dart';
import 'package:grey_note/models/note_model.dart';

class ViewNote extends StatefulWidget {
  final NoteModel? note;
  const ViewNote({super.key, required this.note});

  @override
  State<ViewNote> createState() => _ViewNoteState();
}

class _ViewNoteState extends State<ViewNote> {
  // ViewNote vn = ViewNote();
  final titleController = TextEditingController();
  final noteController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.note?.title);
    titleController.text = widget.note?.title;
    noteController.text = widget.note?.note;
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Note"),
        centerTitle: true,
        actions: [
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 16.0, 0),
              child: TextButton(
                child: const Icon(Icons.done),
                onPressed: () async {
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
            decoration: const InputDecoration(hintText: "Title.."),
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
          ),
          const SizedBox(
            height: 20.0,
          ),
        ]),
      ),
    );
  }
}
