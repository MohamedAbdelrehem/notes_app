import 'package:flutter/material.dart';
import 'package:notes_app/data/hive_database.dart';
import 'package:notes_app/models/note.dart';

class NoteData extends ChangeNotifier {
//hive database
  final db = HiveDatabase();
//overall list note
  List<Note> allNotes = [
    //defult the first note
    Note(id: 0, text: 'first note')
  ];
//initialize the list
  void initializeNotes() {
    allNotes = db.loadNotes();
  }

//get the note
  List<Note> getAllNotes() {
    return allNotes;
  }

//add a new note
  void addNewNote(Note note) {
    allNotes.add(note);
    notifyListeners();
  }

//update the note
  void updateNote(Note note, String text) {
    for (int i = 0; i < allNotes.length; i++) {
      if (allNotes[i].id == note.id) {
        allNotes[i].text = text;
      }
    }
    notifyListeners();
  }

//delete the note
  void deleteNote(Note note) {
    allNotes.remove(note);
    notifyListeners();
  }
}
