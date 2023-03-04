import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:notes_app/constants/constants.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/models/note_data.dart';
import 'package:provider/provider.dart';

class EditingNotePage extends StatefulWidget {
  Note note;
  bool isNewNote;
  EditingNotePage({super.key, required this.note, required this.isNewNote});

  @override
  State<EditingNotePage> createState() => _EditingNotePageState();
}

class _EditingNotePageState extends State<EditingNotePage> {
  QuillController _controller = QuillController.basic();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadExistingNote();
  }

  //load existing note
  loadExistingNote() {
    final doc = Document()..insert(0, widget.note.text);
    setState(() {
      _controller = QuillController(
          document: doc, selection: const TextSelection.collapsed(offset: 0));
    });
  }

  //adding new note
  void addNewNote() {
    //get new id
    int id = Provider.of<NoteData>(context, listen: false).getAllNotes().length;

    // get text from editor
    String text = _controller.document.toPlainText();
    //add the new note
    Provider.of<NoteData>(context, listen: false)
        .addNewNote(Note(id: id, text: text));
  }

  // update existing note
  void updateNote() {
    //get text from editor
    String text = _controller.document.toPlainText();
    //update note
    Provider.of<NoteData>(context, listen: false).updateNote(widget.note, text);
  }

  //!The UI
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.mainTheme,
          elevation: 1,
          leading: IconButton(
            onPressed: () {
              //it is new note
              if (widget.isNewNote && !_controller.document.isEmpty()) {
                addNewNote();
              }
              //it is existing note
              else {
                updateNote();
              }
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new),
            color: Colors.black,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Column(
            children: [
              //toolbar
              QuillToolbar.basic(
                controller: _controller,
                showAlignmentButtons: false,
                showUnderLineButton: false,
                showBackgroundColorButton: false,
                showBoldButton: false,
                showCenterAlignment: false,
                showClearFormat: false,
                showCodeBlock: false,
                showColorButton: false,
                showDirection: false,
                showDividers: false,
                showFontFamily: false,
                showFontSize: false,
                showHeaderStyle: false,
                showIndent: false,
                showInlineCode: false,
                showItalicButton: false,
                showJustifyAlignment: false,
                showLeftAlignment: false,
                showLink: false,
                showListBullets: false,
                showListCheck: false,
                showListNumbers: false,
                showQuote: false,
                showRightAlignment: false,
                showSearchButton: false,
                showSmallButton: false,
                showStrikeThrough: false,
              ),

              //editor
              Expanded(
                  child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: QuillEditor.basic(
                      controller: _controller, readOnly: false),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
