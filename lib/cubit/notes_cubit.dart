import 'package:flutter_application_2/cubit/notes_state.dart';
import 'package:flutter_application_2/model/note_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(const NotesState());

  final _uuid = const Uuid();

  void addNote(String title, String content) {
    if (title.isEmpty || content.isEmpty) {
      return;
    }
    final note = NoteModel(id: _uuid.v4(), title: title, content: content);

    emit(state.copyWith(notes: [...state.notes, note]));
  }

  void deleteNote(String id) {
    final updatedNotes = state.notes.where((note) => note.id != id).toList();
    emit(state.copyWith(notes: updatedNotes));
  }

  void updateNote(NoteModel note) {
    final updatedNotes = state.notes
        .map((n) => n.id == note.id ? note : n)
        .toList();
    emit(state.copyWith(notes: updatedNotes));
  }

  void toggleImportance(String id) {
    final updatedNotes = state.notes
        .map((n) => n.id == id ? n.copyWith(important: true) : n)
        .toList();
    emit(state.copyWith(notes: updatedNotes));
  }
  void toggleNotImportance(String id) {
    final updatedNotes = state.notes
        .map((n) => n.id == id ? n.copyWith(important: false) : n)
        .toList();
    emit(state.copyWith(notes: updatedNotes));
  }
}
