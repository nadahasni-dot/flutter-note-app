import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/note_controller.dart';
import '../models/note_model.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({Key? key}) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController inputTitle = TextEditingController();
  TextEditingController inputDescription = TextEditingController();

  final _controller = Get.find<NoteController>();

  Note note = Get.arguments;

  @override
  void initState() {
    super.initState();

    inputTitle.text = note.title;
    inputDescription.text = note.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Note')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: inputTitle,
                maxLines: 1,
                style: const TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Title',
                  hintStyle: TextStyle(color: Colors.white70),
                ),
                validator: (title) => title != null && title.isEmpty
                    ? 'The title cannot be empty'
                    : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                minLines: 5,
                maxLines: 10,
                controller: inputDescription,
                style: const TextStyle(color: Colors.white60, fontSize: 18),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Type something...',
                  hintStyle: TextStyle(color: Colors.white60),
                ),
                validator: (title) => title != null && title.isEmpty
                    ? 'The description cannot be empty'
                    : null,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _controller.updatenote(
                note.id!, inputTitle.text, inputDescription.text);
          }
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
