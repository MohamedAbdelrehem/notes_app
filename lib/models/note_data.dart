import 'package:notes_app/models/note.dart';

class NoteData {
//overall list note
  List<Note> allNotes = [
    //defult the first note
    Note(id: 0, text: 'first note')
  ];
//get the note
  List<Note> getAllNotes() {
    return allNotes;
  }

//add a new note
  void addNewNote(Note note) {
    allNotes.add(note);
  }

//update the note
  void updateNote(Note note, String text) {
    for (int i = 0; i < allNotes.length; i++) {
      if (allNotes[i].id == note.id) {
        allNotes[i].text == text;
      }
    }
  }

//delete the note
  void deleteNote(Note note) {
    allNotes.remove(note);
  }
}
