import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/notes_list_page.dart';
import 'providers/notes_provider.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const NotesApp());
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NotesProvider()..loadNotes(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Notes App',
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: const Color(0xfff7f8fa),
          textTheme: GoogleFonts.poppinsTextTheme(),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const NotesListPage(),
      ),
    );
  }
}
