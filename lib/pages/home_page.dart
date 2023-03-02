import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/models/note_data.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NoteData>(
        builder: (context, value, child) => Scaffold(
              backgroundColor: CupertinoColors.systemGroupedBackground,
              // appBar: AppBar(backgroundColor: Colors.cyan[200]),
              floatingActionButton: FloatingActionButton(
                onPressed: createNewNote(),
                backgroundColor: Colors.cyan[200],
                child: Icon(Icons.note_add),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //heading
                  Padding(
                    padding: EdgeInsets.only(left: 25.0, top: 75),
                    child: Text(
                      "Notes",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ),
                  //list of notes
                  CupertinoListSection.insetGrouped(
                    children: List.generate(
                        value.getAllNotes().length,
                        (index) => CupertinoListTile(
                            title: Text(value.getAllNotes()[index].text))),
                  )
                ],
              ),
            ));
  }
}
