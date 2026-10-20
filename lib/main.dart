import 'package:flutter/material.dart';

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
      home: Scaffold(        
        body: MyAppWidget(),
      ),
    );
  }
}

class MyAppWidget extends StatefulWidget {
  const MyAppWidget({super.key});

  @override
  _MyAppWidgetState createState() => _MyAppWidgetState();
}

class _MyAppWidgetState extends State<MyAppWidget> {
  final TextEditingController _controller = TextEditingController();
  String _text = '';
  final List<String> _notes = [];

  @override
  void initState() {
    super.initState();
    _controller.addListener(_updateText);
  }

  @override
  void dispose() {
    _controller.removeListener(_updateText);
    _controller.dispose();
    super.dispose();
  }

  void _clearText() {
    _controller.clear();
  }

  void _updateText() {
    setState(() {
      _text = _controller.text;
    });
  }

  void _addNote() {
    if (_text.isEmpty) return;
    setState(() {
      _notes.add(_text);
      _clearText();
    });
  }

  void _editNote(int index) {
    setState(() {
      _controller.text = _notes[index];
      _notes.removeAt(index);
    });
  }

  void _deleteNote(int index) {
    setState(() {
      _notes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: 'Введите заметку',
          ),
        ),
        ElevatedButton(
          onPressed: _clearText,
          child: Text('Отчистить текст'),
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: _addNote,
          child: Text('Сохранить'),
        ),
        SizedBox(height: 16),
        Expanded(     
          child: ListView.builder(
            itemCount: _notes.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_notes[index]),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => _editNote(index),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _deleteNote(index),
                    ),
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}