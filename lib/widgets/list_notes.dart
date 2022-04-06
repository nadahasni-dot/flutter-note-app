import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../controllers/note_controller.dart';
import 'note_card.dart';

class ListNotes extends StatefulWidget {
  const ListNotes({Key? key}) : super(key: key);

  @override
  State<ListNotes> createState() => _ListNotesState();
}

class _ListNotesState extends State<ListNotes> {
  final _controller = Get.find<NoteController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (_controller.listNotes.isEmpty) {
        return const Center(child: Text('There is no notes saved yet'));
      }

      return StaggeredGridView.countBuilder(
        padding: const EdgeInsets.all(8),
        itemCount: _controller.listNotes.length,
        staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
          final note = _controller.listNotes[index];

          return NoteCard(note: note, index: index);
        },
      );
    });
  }
}
