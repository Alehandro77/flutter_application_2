import 'package:flutter/foundation.dart';

@immutable
class NotesState {
  final String text;
  final List<String> notes;

  const NotesState({
    this.text = '',
    this.notes = const [],
  });
}