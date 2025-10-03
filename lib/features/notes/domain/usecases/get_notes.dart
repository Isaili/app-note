import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../entities/note.dart';
import '../repositories/note_repository.dart';

class GetNotes {
  final NoteRepository repository;

  GetNotes(this.repository);

  Future<Either<Failure, List<Note>>> call() async {
    return await repository.getNotes();
  }
}