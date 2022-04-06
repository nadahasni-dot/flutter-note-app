const String tableNotes = 'notes';

class NoteFields {
  static final List<String> values = [
    /// Add all fields
    id, title, description, createdAt
  ];

  static const String id = '_id';
  static const String title = 'title';
  static const String description = 'description';
  static const String createdAt = 'createdAt';
}

class Note {
  final int? id;
  final String title;
  final String description;
  final DateTime createdAt;

  Note({
    this.id,
    required this.title,
    required this.description,
    required this.createdAt,
  });

  Note copy({
    final int? id,
    final String? title,
    final String? description,
    final DateTime? createdAt,
  }) =>
      Note(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        createdAt: createdAt ?? this.createdAt,
      );

  static Note fromJson(Map<String, dynamic> json) => Note(
        id: json[NoteFields.id] as int?,
        title: json[NoteFields.title] as String,
        description: json[NoteFields.description] as String,
        createdAt: DateTime.parse(json[NoteFields.createdAt] as String),
      );

  Map<String, dynamic> toJson() => {
        NoteFields.id: id,
        NoteFields.title: title,
        NoteFields.description: description,
        NoteFields.createdAt: createdAt.toIso8601String(),
      };
}
