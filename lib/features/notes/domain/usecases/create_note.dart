import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../entities/note.dart';
import '../repositories/note_repository.dart';

class CreateNote {
  final NoteRepository repository;

  CreateNote(this.repository);

  Future<Either<Failure, Note>> call(Note note) async {
    return await repository.createNote(note);
  }
}