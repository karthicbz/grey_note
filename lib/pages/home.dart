import 'package:flutter/material.dart';
import 'package:grey_note/models/note_model.dart';
import 'package:grey_note/pages/settings_page.dart';
import 'package:grey_note/pages/view_note.dart';
import 'package:grey_note/providers/home_provider.dart';
import 'package:grey_note/providers/settings_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          context.watch<SettingsProvider>().dark ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: context.watch<SettingsProvider>().dark
            ? Colors.black
            : Colors.white,
        title: Text(
          'Grey Notes',
          style: TextStyle(
              color: context.watch<SettingsProvider>().dark
                  ? Colors.white
                  : Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              },
              icon: Icon(Icons.settings_outlined,
                  color: context.watch<SettingsProvider>().dark
                      ? Colors.white
                      : Colors.black))
        ],
      ),
      body: ListView.builder(
          itemCount: context.watch<HomeProvider>().allNotes.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: Card(
                color: Colors.blueGrey,
                child: ListTile(
                  leading: Text(
                    (index + 1).toString(),
                    style: const TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.w400),
                  ),
                  title: context
                          .watch<HomeProvider>()
                          .allNotes[index]
                          .isLongPressed
                      ? Row(
                          children: [
                            ElevatedButton(
                                onPressed: () {}, child: const Text('Delete')),
                            const SizedBox(
                              width: 10.0,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  context
                                      .watch<HomeProvider>()
                                      .allNotes[index]
                                      .isLongPressed = false;
                                },
                                child: const Text('Cancel'))
                          ],
                        )
                      : Text(
                          context.watch<HomeProvider>().allNotes[index].title,
                          style: const TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w400),
                        ),
                  subtitle: context
                          .watch<HomeProvider>()
                          .allNotes[index]
                          .isLongPressed
                      ? Container()
                      : Text(
                          'Created on: ${context.watch<HomeProvider>().allNotes[index].dateTime}'),
                  onLongPress: () {
                    // print(allNotes[index].isLongPressed);

                    context
                        .watch<HomeProvider>()
                        .allNotes[index]
                        .isLongPressed = true;
                  },
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ViewNote(
                            note: context
                                .watch<HomeProvider>()
                                .allNotes[index])));
                  },
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/new-note');
          if (!context.mounted) return;
          context.read<HomeProvider>().allNotes = [];
          context.read<HomeProvider>().initializeHomeCards();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
