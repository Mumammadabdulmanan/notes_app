import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/notes_provider.dart';
import 'note_form_page.dart';
import 'note_detail_page.dart';

class NotesListPage extends StatelessWidget {
  const NotesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NotesProvider>(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff6a5af9), Color(0xff887efc)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: Center(
              child: Text(
                "My Notes",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(color: Colors.black.withOpacity(.3), blurRadius: 6),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),

      body: provider.notes.isEmpty
          ? const Center(
              child: Text(
                "📄 Belum ada catatan.\nTap tombol + untuk membuat.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: provider.notes.length,
              itemBuilder: (context, index) {
                final note = provider.notes[index];

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  child: Dismissible(
                    key: ValueKey(note.id),
                    background: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 20),
                      color: Colors.redAccent,
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (_) => provider.remove(note.id!),
                    child: Card(
                      elevation: 6,
                      shadowColor: Colors.black.withOpacity(.1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(18),
                        title: Text(
                          note.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          note.content.length > 60
                              ? "${note.content.substring(0, 60)}..."
                              : note.content,
                          style: const TextStyle(fontSize: 14),
                        ),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => NoteDetailPage(note: note),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),

      floatingActionButton: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
          child: FloatingActionButton(
            backgroundColor: Colors.deepPurple.withOpacity(.8),
            elevation: 6,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const NoteFormPage()),
            ),
            child: const Icon(Icons.add, size: 30, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
