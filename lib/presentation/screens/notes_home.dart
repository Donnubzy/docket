
import 'package:docket/data/model/note.dart';
import 'package:docket/data/repo/notes_db.dart';
import 'package:docket/presentation/widgets/drawer.dart';
import 'package:docket/presentation/widgets/note_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class NotesHome extends StatefulWidget {
  const NotesHome({super.key});

  @override
  State<NotesHome> createState() => _NotesHomeState();
}

class _NotesHomeState extends State<NotesHome> {
  TextEditingController noteController = TextEditingController();

  void create(){
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Create New Note"),
            content: TextField(
              controller: noteController,
            ),
            backgroundColor: Theme.of(context).colorScheme.surface,
            actions: [
              OutlinedButton(
                  onPressed: ()=> Navigator.pop(context),
                  child: const Text("Cancel")
              ),
              ElevatedButton(
                  onPressed: (){
                    context.read<NotesDatabase>().addNote(noteController.text);
                    noteController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text("Save")
              )
            ],
          );
        });
  }

  void readNotes(){
    context.read<NotesDatabase>().getNotes();
  }

  void updateNote(Note note){
    noteController.text = note.text;

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Update Note"),
            content: TextField(
              controller: noteController,
            ),
            backgroundColor: Theme.of(context).colorScheme.surface,
            actions: [
              OutlinedButton(
                  onPressed: ()=> Navigator.pop(context),
                  child: const Text("Cancel")
              ),
              ElevatedButton(
                  onPressed: (){
                    context.read<NotesDatabase>()
                        .updateNote(note.id, noteController.text);
                    noteController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text("Update")
              )
            ],
          );
        });
  }

  void delete(int id){
    context.read<NotesDatabase>().deleteNote(id);
  }

  @override
  void initState() {
    super.initState();
    readNotes();
  }

  @override
  Widget build(BuildContext context) {
    final db = context.watch<NotesDatabase>();
    List<Note> currentNotesInDb = db.currentNotes;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: create,
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.inversePrimary
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      drawer: const MyDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text("Notes",
              style: GoogleFonts.dmSerifText(
                textStyle: TextStyle(
                    fontSize: 48,
                    color: Theme.of(context).colorScheme.inversePrimary
                ),
              )
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: currentNotesInDb.length,
                itemBuilder: (_,index) {
                  final individualNote = currentNotesInDb[index];
                  return NoteTile(
                    text: individualNote.text,
                    onUpdate: () => updateNote(individualNote),
                    onDelete: () => delete(individualNote.id),
                  );
                }
            ),
          ),
        ],
      ),
    );
  }
}
