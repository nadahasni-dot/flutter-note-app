import 'dart:developer';

import 'package:get/get.dart';

import '../models/note_model.dart';
import '../services/database_service.dart';

class NoteController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isDetailLoading = true.obs;

  RxList<Note> listNotes = <Note>[].obs;
  RxList<Note> listSearch = <Note>[].obs;

  Note? noteDetail;

  searchNotes(String query) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final searchResult = listNotes
        .where((note) => note.title.toLowerCase().contains(query))
        .toList();

    listSearch.clear();
    listSearch.addAll(searchResult);
  }

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

  Future getDetail(int noteId) async {
    isDetailLoading.value = true;
    try {
      noteDetail = await DatabaseService.instance.readNote(noteId);

      isDetailLoading.value = false;
    } catch (e) {
      isDetailLoading.value = false;
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

  Future updatenote(int id, String title, String description) async {
    try {
      await DatabaseService.instance.update(
        Note(
            id: id,
            title: title,
            description: description,
            createdAt: DateTime.now()),
      );

      Get.back();

      getDetail(id);
      getAllNotes();
    } catch (e) {
      log(e.toString());
    }
  }

  Future deleteNote(int id) async {
    try {
      await DatabaseService.instance.delete(id);

      Get.until((route) => route.isFirst);

      getAllNotes();
    } catch (e) {
      log(e.toString());
    }
  }
}
