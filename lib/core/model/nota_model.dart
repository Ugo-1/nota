const String tableName = 'nota';

class NoteFields {
  static String id = '_id';
  static String colorIndex = 'colorIndex';
  static String isFavorite = 'isFavorite';
  static String title ='title';
  static String description = 'description';
  static String createdTime = 'createdTime';

  static List<String> columns = [
    id,
    colorIndex,
    isFavorite,
    title,
    description,
    createdTime,
  ];
}

class Nota{
  final int? id;
  final int? colorIndex;
  final bool isFavorite;
  final String title;
  final String description;
  final DateTime createdTime;

  const Nota({
    this.id,
    this.colorIndex,
    required this.isFavorite,
    required this.title,
    required this.description,
    required this.createdTime,
  });

  Nota copy({
    int? id,
    int? colorIndex,
    bool? isFavorite,
    String? title,
    String? description,
    DateTime? createdTime,
  }) {
    return Nota(
      id: id ?? this.id,
      colorIndex: colorIndex ?? this.colorIndex,
      isFavorite: isFavorite ?? this.isFavorite,
      title: title ?? this.title,
      description: description ?? this.description,
      createdTime: createdTime ?? this.createdTime,
    );
  }

  factory Nota.fromJson(Map<String, dynamic> json){
    return Nota(
      id: json[NoteFields.id] as int,
      colorIndex: json[NoteFields.colorIndex] as int?,
      isFavorite: json[NoteFields.isFavorite] as int == 1,
      title: json[NoteFields.title] as String,
      description: json[NoteFields.description] as String,
      createdTime: DateTime.parse(json[NoteFields.createdTime] as String),
    );
  }

  Map<String, dynamic> toJson(){
    return {
      NoteFields.id: id,
      NoteFields.colorIndex: colorIndex,
      NoteFields.isFavorite: isFavorite? 1:0,
      NoteFields.title: title,
      NoteFields.description: description,
      NoteFields.createdTime: createdTime.toIso8601String(),
    };
  }
}