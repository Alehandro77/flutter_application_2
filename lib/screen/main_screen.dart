import 'package:flutter/material.dart';
import 'package:flutter_application_2/screen/note_edit_screen.dart';
import 'package:flutter_application_2/screen/note_screen.dart';
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
              final cubit = context.read<NotesCubit>();
              return Dismissible(
                key: ValueKey(note.id),
                direction: DismissDirection.horizontal,

                confirmDismiss: (direction) async {
                  if (direction == DismissDirection.endToStart) {
                    return true;
                  }
                  cubit.toggleNotImportance(note.id);
                  return false;
                },
                onDismissed: (_) => cubit.deleteNote(note.id),

                background: Container(
                  color: Colors.green,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(Icons.star_border, color: Colors.white),
                ),
                secondaryBackground: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),

                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (_) => NoteScreen(note: note)));
                  },
                  onDoubleTap: () => cubit.toggleImportance(note.id),
                  onLongPress: () {
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (_) => NoteEditScreen(note: note)));
                  },
                child: ListTile(
                  tileColor: note.important ? Colors.amber.withOpacity(0.2) : null,
                  title: Row(
                    children: [
                      if (note.important) ...[
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        const SizedBox(width: 4),
                      ],
                      Expanded(child: Text(note.title)),
                    ],
                  ),              
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () =>
                        context.read<NotesCubit>().deleteNote(note.id),
                  ),
                )
                )
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
