import 'package:flutter/material.dart';
import '../../../../core/error/failure.dart';
import 'package:flutter_application_app/core/error/failure.dart';
import '../../domain/entities/note.dart';
import '../../domain/usecases/get_notes.dart';
import '../../domain/usecases/create_note.dart';
import '../../domain/usecases/delete_note.dart';

class NotesProvider with ChangeNotifier {
  final GetNotes getNotes;
  final CreateNote createNote;
  final DeleteNote deleteNote;

  NotesProvider({
    required this.getNotes,
    required this.createNote,
    required this.deleteNote,
  });

  List<Note> _notes = [];
  List<Note> get notes => _notes;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _error = '';
  String get error => _error;

  Future<void> loadNotes() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    final result = await getNotes();

    result.fold(
      (failure) {
        _error = _mapFailureToMessage(failure as Failure);
        _notes = [];
      },
      (notes) {
        _notes = notes;
        _error = '';
      },
    );

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> addNote(String title, String content) async {
    final newNote = Note(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      content: content,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final result = await createNote(newNote);

    return result.fold(
      (failure) {
        _error = _mapFailureToMessage(failure);
        notifyListeners();
        return false;
      },
      (note) {
        _notes.insert(0, note);
        _error = '';
        notifyListeners();
        return true;
      },
    );
  }

  Future<bool> removeNote(String id) async {
    final result = await deleteNote(id);

    return result.fold(
      (failure) {
        _error = _mapFailureToMessage(failure);
        notifyListeners();
        return false;
      },
      (_) {
        _notes.removeWhere((note) => note.id == id);
        _error = '';
        notifyListeners();
        return true;
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Error del servidor';
      default:
        return 'Error inesperado';
    }
  }
}