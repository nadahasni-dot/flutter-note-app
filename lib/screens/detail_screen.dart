import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/note_controller.dart';
import '../routes/route_names.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final _controller = Get.find<NoteController>();

  int noteId = Get.arguments;

  @override
  void initState() {
    super.initState();
    _controller.getDetail(noteId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Note Detail'),
        actions: [
          IconButton(
            onPressed: () {
              if (_controller.noteDetail == null) return;

              Get.toNamed(RouteNames.editScreen,
                  arguments: _controller.noteDetail);
            },
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () => _controller.deleteNote(noteId),
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: Obx(() {
        if (_controller.isDetailLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 8),
            children: [
              Text(
                _controller.noteDetail!.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                DateFormat.yMMMd().format(_controller.noteDetail!.createdAt),
                style: const TextStyle(color: Colors.white38),
              ),
              const SizedBox(height: 8),
              Text(
                _controller.noteDetail!.description,
                style: const TextStyle(color: Colors.white70, fontSize: 18),
              )
            ],
          ),
        );
      }),
    );
  }
}
