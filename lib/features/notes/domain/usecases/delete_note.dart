import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../repositories/note_repository.dart';

class DeleteNote {
  final NoteRepository repository;

  DeleteNote(this.repository);

  Future<Either<Failure, void>> call(String id) async {
    return await repository.deleteNote(id);
  }
}