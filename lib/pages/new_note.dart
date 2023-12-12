import 'package:flutter/material.dart';

class NewNote extends StatefulWidget {
  const NewNote({super.key});

  @override
  State<NewNote> createState() => _NewNoteState();
}

class _NewNoteState extends State<NewNote> {
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
          const TextField(
            decoration: InputDecoration(hintText: "Title.."),
          ),
          const SizedBox(
            height: 20.0,
          ),
          TextFormField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
          ),
          const SizedBox(
            height: 20.0,
          ),
          OutlinedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.save),
              label: const Text('Save'))
        ]),
      ),
    );
  }
}
