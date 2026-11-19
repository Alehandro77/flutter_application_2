import 'package:flutter/material.dart';
import 'package:flutter_application_2/screen/note_edit_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_application_2/cubit/notes_cubit.dart';
import 'package:flutter_application_2/cubit/notes_state.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Заметки')),
      body: BlocBuilder<NotesCubit, NotesState>(
        builder: (context, state) {
          if (state.notes.isEmpty) {
            return const Center(child: Text('Нет заметок'));
          }
          return ListView.builder(
            itemCount: state.notes.length,
            itemBuilder: (context, index) {
              final note = state.notes[index];
              return ListTile(
                title: Text(note.title),
                subtitle: Text(
                  note.content,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                leading: IconButton(
                  icon: Icon(note.important ? Icons.star : Icons.star_border),
                  onPressed: () =>
                      context.read<NotesCubit>().toggleImportance(note.id),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => NoteEditScreen(note: note),
                    ),
                  );
                },
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () =>
                      context.read<NotesCubit>().deleteNote(note.id),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const NoteEditScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
