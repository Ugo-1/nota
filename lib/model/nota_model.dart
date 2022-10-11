const String tableName = 'nota';

class NoteFields {
  static String id = '_id';
  static String color = 'color';
  static String darkColor = 'darkColor';
  static String isFavorite = 'isFavorite';
  static String title ='title';
  static String description = 'description';
  static String createdTime = 'createdTime';

  static List<String> columns = [
    id,
    color,
    darkColor,
    isFavorite,
    title,
    description,
    createdTime,
  ];
}

class Nota{
  final int? id;
  final String? color;
  final String? darkColor;
  final bool isFavorite;
  final String title;
  final String description;
  final DateTime createdTime;

  const Nota({
    this.id,
    this.color,
    this.darkColor,
    required this.isFavorite,
    required this.title,
    required this.description,
    required this.createdTime,
  });

  Nota copy({
    int? id,
    String? color,
    String? darkColor,
    bool? isFavorite,
    String? title,
    String? description,
    DateTime? createdTime,
  }) {
    return Nota(
      id: id ?? this.id,
      color: color ?? this.color,
      darkColor: darkColor ?? this.darkColor,
      isFavorite: isFavorite ?? this.isFavorite,
      title: title ?? this.title,
      description: description ?? this.description,
      createdTime: createdTime ?? this.createdTime,
    );
  }

  factory Nota.fromJson(Map<String, dynamic> json){
    return Nota(
      id: json[NoteFields.id] as int,
      color: json[NoteFields.color] as String,
      darkColor: json[NoteFields.darkColor] as String,
      isFavorite: json[NoteFields.isFavorite] as int == 1,
      title: json[NoteFields.title] as String,
      description: json[NoteFields.description] as String,
      createdTime: DateTime.parse(json[NoteFields.createdTime] as String),
    );
  }

  Map<String, dynamic> toJson(){
    return {
      NoteFields.id: id,
      NoteFields.color: color,
      NoteFields.darkColor: darkColor,
      NoteFields.isFavorite: isFavorite? 1:0,
      NoteFields.title: title,
      NoteFields.description: description,
      NoteFields.createdTime: createdTime.toIso8601String(),
    };
  }
}