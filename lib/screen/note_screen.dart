import 'package:flutter/material.dart';
import 'package:flutter_application_2/model/note_model.dart';

class NoteScreen extends StatefulWidget {
  final NoteModel note;

  const NoteScreen({super.key, required this.note});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Заметка'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.note.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(widget.note.content),
          ],
        ),
      ),
    );
  }
}