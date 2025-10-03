import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../entities/note.dart';

abstract class NoteRepository {
  Future<Either<Failure, List<Note>>> getNotes();
  Future<Either<Failure, Note>> createNote(Note note);
  Future<Either<Failure, void>> deleteNote(String id);
}