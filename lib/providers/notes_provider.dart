import 'package:flutter/material.dart';
import '../db/db_helper.dart';
import '../models/note.dart';

class NotesProvider extends ChangeNotifier {
  List<Note> notes = [];
  final DBHelper db = DBHelper();

  Future<void> loadNotes() async {
    notes = await db.getNotes();
    notifyListeners();
  }

  Future<void> add(Note note) async {
    await db.insert(note);
    await loadNotes();
  }

  Future<void> remove(int id) async {
    await db.delete(id);
    await loadNotes();
  }

  Future<void> edit(Note note) async {
    await db.update(note);
    await loadNotes();
  }
}
