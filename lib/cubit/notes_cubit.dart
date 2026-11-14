import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(const NotesState()) {
    _controller.addListener(_updateText);
  }

  final TextEditingController _controller = TextEditingController();
  String _text = '';
  final List<String> _notes = [];

  TextEditingController get controller => _controller;

  void _clearText() {
    _controller.clear();
  }

  void _updateText() {
    _text = _controller.text;
    emit(NotesState(text: _text, notes: _notes));
  }

  void clearText() {
    _clearText();
  }

  void addNote() {
    if (_text.isEmpty) return;
    _notes.add(_text);
    _clearText();
    emit(NotesState(text: _text, notes: _notes));
  }

  void editNote(int index) {
    _controller.text = _notes[index];
    _notes.removeAt(index);
    emit(NotesState(text: _text, notes: _notes));
  }

  void deleteNote(int index) {
    _notes.removeAt(index);
    emit(NotesState(text: _text, notes: _notes));
  }

  @override
  Future<void> close() {
    _controller.removeListener(_updateText);
    _controller.dispose();
    return super.close();
  }
}