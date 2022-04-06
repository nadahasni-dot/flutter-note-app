import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/widgets/list_search.dart';

import '../controllers/note_controller.dart';
import '../routes/route_names.dart';
import '../services/database_service.dart';
import '../widgets/list_notes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = Get.put(NoteController());

  @override
  void initState() {
    super.initState();
    _controller.getAllNotes();
  }

  @override
  void dispose() {
    super.dispose();
    DatabaseService.instance.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        actions: [
          IconButton(
            onPressed: () =>
                showSearch(context: context, delegate: CustomSearchDelegate()),
            icon: const Icon(Icons.search),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(RouteNames.createScreen),
        child: const Icon(Icons.add),
      ),
      body: const ListNotes(),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          },
          icon: const Icon(Icons.clear),
        ),
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back),
      );

  @override
  Widget buildResults(BuildContext context) {
    return ListSearch(query: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListSearch(query: query);
  }
}
