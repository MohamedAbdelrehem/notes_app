import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../models/note.dart';

class HiveDataBase {
  // refrance our hive box
  final _myBox = Hive.box('note_database');
  // load notes
  List<Note> loadNotes() {
    List<Note> savedNotesFormatted = [];

    // if there exist notes, return that, otherwise return empty list
    if (_myBox.get("ALL_NOTES") != null) {
      List<dynamic> savedNotes = _myBox.get("ALL_NOTES");
      for (int i = 0; i < savedNotes.length; i++) {
        //create individual note
        Note individualNote =
            Note(id: savedNotes[i][0], text: savedNotes[i][1]);
        print("id = ${savedNotes[i][0]} text = ${savedNotes[i][1]}");
        //add to list
        savedNotesFormatted.add(individualNote);
      }
    }
    return savedNotesFormatted;
  }
}
