import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/constants/constants.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/models/note_data.dart';
import 'package:provider/provider.dart';
import 'editing_note_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<NoteData>(context, listen: false).initializeNotes();
  }

  //create a new note
  void createNewNote() {
    //create a new id
    int id = Provider.of<NoteData>(context, listen: false).getAllNotes().length;

    //create a blank note
    Note newNote = Note(id: id, text: "");

    //go to edit the note
    goToNotePage(newNote, true);
  }

  //go to note editing page
  void goToNotePage(Note note, bool isNewNote) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditingNotePage(
                  note: note,
                  isNewNote: isNewNote,
                )));
  }

  //delete note
  void deleteNote(Note note) {
    Provider.of<NoteData>(context, listen: false).deleteNote(note);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteData>(
        builder: (context, value, child) => Scaffold(
              backgroundColor: CupertinoColors.systemGroupedBackground,
              // appBar: AppBar(backgroundColor: Colors.cyan[200]),
              floatingActionButton: FloatingActionButton(
                onPressed: createNewNote,
                backgroundColor: MyColors.mainTheme,
                child: const Icon(Icons.add),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //heading
                  Padding(
                    padding: EdgeInsets.only(left: 25.0, top: 75),
                    child: Text(
                      "Notes",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: MyColors.mainTheme,
                      ),
                    ),
                  ),
                  //list of notes

                  value.getAllNotes().isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: Text("create a Note from the + icon",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 128, 128, 128))),
                          ),
                        )
                      : CupertinoListSection.insetGrouped(
                          children: List.generate(
                            value.getAllNotes().length,
                            (index) => CupertinoListTile(
                              title: Text(
                                value.getAllNotes()[index].text,
                                style:
                                    TextStyle(color: MyColors.secoundryTheme),
                              ),
                              onTap: () => goToNotePage(
                                  value.getAllNotes()[index], false),
                              trailing: IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: MyColors.secoundryTheme,
                                ),
                                onPressed: () =>
                                    deleteNote(value.getAllNotes()[index]),
                              ),
                            ),
                          ),
                        )
                ],
              ),
            ));
  }
}
