import 'dart:async';

import 'package:flutter/material.dart';
import 'package:grey_note/models/note_model.dart';
import 'package:grey_note/pages/settings_page.dart';
import 'package:grey_note/pages/view_note.dart';
import 'package:grey_note/providers/home_provider.dart';
import 'package:grey_note/providers/settings_provider.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

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
      body: context.watch<HomeProvider>().allNotes.isNotEmpty
          ? ListView.builder(
              itemCount: context.watch<HomeProvider>().allNotes.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Card(
                    color: Color(int.parse(
                        context.watch<SettingsProvider>().homeCardsColor)),
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
                                    onPressed: () async {
                                      context.read<HomeProvider>().deleteNote(
                                          context
                                              .read<HomeProvider>()
                                              .allNotes[index]
                                              .uuid);
                                      context.read<HomeProvider>().allNotes =
                                          [];
                                      await Timer(Duration(seconds: 1), () {});
                                      await context
                                          .read<HomeProvider>()
                                          .initializeHomeCards();
                                    },
                                    child: const Text('Delete')),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      context
                                          .read<HomeProvider>()
                                          .isCancelPressed(context
                                              .read<HomeProvider>()
                                              .allNotes[index]
                                              .uuid);
                                    },
                                    child: const Text('Cancel'))
                              ],
                            )
                          : Text(
                              context
                                  .watch<HomeProvider>()
                                  .allNotes[index]
                                  .title,
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

                        context.read<HomeProvider>().isCardLongPressed(
                            context.read<HomeProvider>().allNotes[index].uuid);
                      },
                      onTap: () async {
                        await Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ViewNote(
                                note: context
                                    .watch<HomeProvider>()
                                    .allNotes[index])));
                        if (!context.mounted) return;
                        context.read<HomeProvider>().allNotes = [];
                        context.read<HomeProvider>().initializeHomeCards();
                      },
                    ),
                  ),
                );
              })
          : Center(
              child: LottieBuilder.asset(
                'assets/animations/empty_list.json',
              ),
            ),
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
