import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/notes_cubit.dart';
import 'cubit/notes_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: BlocProvider(
        create: (_) => NotesCubit(),
        child: const Scaffold(
          body: MyAppWidget(),
        ),
      ),
    );
  }
}

class MyAppWidget extends StatelessWidget {
  const MyAppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesCubit, NotesState>(
      builder: (context, state) {
        final cubit = context.read<NotesCubit>();

        return Column(
          children: [
            TextField(
              controller: cubit.controller,
              decoration: const InputDecoration(
                hintText: 'Введите заметку',
              ),
            ),
            ElevatedButton(
              onPressed: cubit.clearText,
              child: const Text('Отчистить текст'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: cubit.addNote,
              child: const Text('Сохранить'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: state.notes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(state.notes[index]),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => cubit.editNote(index),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => cubit.deleteNote(index),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}