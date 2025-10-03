import 'package:equatable/equatable.dart';
import '../../domain/entities/note.dart';

class NoteModel extends Equatable {
  final String id;
  final String title;
  final String content;
  final String createdAt;
  final String updatedAt;

  const NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  // Mapear desde el JSON de tu API
  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id']?.toString() ?? '', // Asegurar que sea string
      title: json['titulo'] ?? '', // Mapear 'titulo' a 'title'
      content: json['parrafo'] ?? '', // Mapear 'parrafo' a 'content'
      createdAt: json['createdAt'] ?? DateTime.now().toIso8601String(),
      updatedAt: json['updatedAt'] ?? DateTime.now().toIso8601String(),
    );
  }

  // Mapear a JSON para enviar a tu API
  Map<String, dynamic> toJson() {
    return {
      'titulo': title,    // Mapear 'title' a 'titulo'
      'parrafo': content, // Mapear 'content' a 'parrafo'
      'estatus': 'en-progreso', // Valor por defecto
    };
  }

  // Para crear/actualizar sin ID (cuando el servidor genera el ID)
  Map<String, dynamic> toJsonForCreate() {
    return {
      'titulo': title,
      'parrafo': content,
      'estatus': 'en-progreso',
    };
  }

  Note toEntity() {
    return Note(
      id: id,
      title: title,
      content: content,
      createdAt: DateTime.parse(createdAt),
      updatedAt: DateTime.parse(updatedAt),
    );
  }

  factory NoteModel.fromEntity(Note note) {
    return NoteModel(
      id: note.id,
      title: note.title,
      content: note.content,
      createdAt: note.createdAt.toIso8601String(),
      updatedAt: note.updatedAt.toIso8601String(),
    );
  }

  @override
  List<Object?> get props => [id, title, content, createdAt, updatedAt];
}