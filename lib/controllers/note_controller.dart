import 'dart:developer';

import 'package:get/get.dart';

import '../models/note_model.dart';
import '../services/database_service.dart';

class NoteController extends GetxController {
  RxBool isLoading = true.obs;
  RxList<Note> listNotes = <Note>[].obs;

  Future getAllNotes() async {
    isLoading.value = true;
    try {
      final notes = await DatabaseService.instance.readAllNotes();

      listNotes.clear();
      listNotes.addAll(notes);

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
  }

  Future createNote(String title, String description) async {
    try {
      await DatabaseService.instance.create(
        Note(title: title, description: description, createdAt: DateTime.now()),
      );

      Get.until((route) => route.isFirst);

      getAllNotes();
    } catch (e) {
      log(e.toString());
    }
  }
}
