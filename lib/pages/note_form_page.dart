import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/note.dart';
import '../providers/notes_provider.dart';

class NoteFormPage extends StatefulWidget {
  final Note? editNote;
  const NoteFormPage({super.key, this.editNote});

  @override
  State<NoteFormPage> createState() => _NoteFormPageState();
}

class _NoteFormPageState extends State<NoteFormPage> {
  final titleC = TextEditingController();
  final contentC = TextEditingController();

  @override
  void initState() {
    if (widget.editNote != null) {
      titleC.text = widget.editNote!.title;
      contentC.text = widget.editNote!.content;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NotesProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.editNote == null ? "Add Note" : "Edit Note"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            TextField(
              controller: titleC,
              decoration: InputDecoration(
                labelText: "Title",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const SizedBox(height: 14),
            Expanded(
              child: TextField(
                controller: contentC,
                maxLines: 99999,
                decoration: InputDecoration(
                  labelText: "Write your note here...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () {
                if (widget.editNote == null) {
                  provider.add(
                    Note(
                      title: titleC.text,
                      content: contentC.text,
                      createdAt: DateTime.now().toString(),
                    ),
                  );
                } else {
                  provider.edit(
                    Note(
                      id: widget.editNote!.id,
                      title: titleC.text,
                      content: contentC.text,
                      createdAt: widget.editNote!.createdAt,
                    ),
                  );
                }
                Navigator.pop(context);
              },
              child: Text(widget.editNote == null ? "Save" : "Update"),
            ),
          ],
        ),
      ),
    );
  }
}
