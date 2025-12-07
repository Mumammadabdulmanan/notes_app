import 'package:flutter/material.dart';
import '../models/note.dart';

class NoteDetailPage extends StatelessWidget {
  final Note note;
  const NoteDetailPage({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(note.title)),

      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Text(
          note.content,
          style: const TextStyle(fontSize: 18, height: 1.4),
        ),
      ),
    );
  }
}
