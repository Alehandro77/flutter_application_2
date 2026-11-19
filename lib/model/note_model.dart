class NoteModel {
  String id;
  String title;
  String content;
  bool important;

  NoteModel({
    required this.id,
    required this.title,
    required this.content,
    this.important = false,
  });

  NoteModel copyWith({
    String? id,
    String? title,
    String? content,
    bool? important,
  }) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      important: important ?? this.important,
    );
  }
}
