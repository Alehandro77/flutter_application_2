import 'package:flutter_application_2/model/note_model.dart';

class NotesState {
  final List<NoteModel> notes;
  final bool isLoading;

  const NotesState({this.notes = const [], this.isLoading = false});

  NotesState copyWith({List<NoteModel>? notes, bool? isLoading}) {
    return NotesState(
      notes: notes ?? this.notes,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
