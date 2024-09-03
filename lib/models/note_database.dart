import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_practice/models/note.dart';

class NoteDatabase with ChangeNotifier {
  static late Isar isar;

  // intialize the isar db
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [NoteSchema],
      directory: dir.path,
    );
  }

  // list of tasks
  List<Note> currentNotes = [];

  // CREATE
  Future<void> addNote(String textFromUser) async {
    // get user note text and asign it to note object
    final note = Note()..taskName = textFromUser;

    // write the note object to db
    await isar.writeTxn(() => isar.notes.put(note));

    // re-read all notes from db
    fetchNotes();
  }

  // READ
  Future<void> fetchNotes() async {
    // get the list of notes in db

    // logic to fetch notes

    // curr = [1,2]
    // new = current
    // new = [1,2]
    // curr.clear() => []
    // curr.add(new)

    List<Note> existingNotes = await isar.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(existingNotes);
    notifyListeners();
  }

  // UPDATE
  Future<void> updateNotes(String newTaskText, int id) async {
    // get the already existing note on that id
    // check if the existing note is empty or not, if not then
    // update the new text from user in the existing note
    // re-read from db to see the changes

    final existingNote = await isar.notes.get(id);
    if (existingNote != null) {
      existingNote.taskName = newTaskText;
      await isar.writeTxn(() => isar.notes.put(existingNote));
    }
    await fetchNotes();
  }

  // DELETE
  Future<void> deleteNotes(int id) async {
    // delete the note of the specific id
    await isar.writeTxn(() => isar.notes.delete(id));

    // re-read from db to see the changes
    await fetchNotes();
  }
}
