import 'package:flutter_application_app/core/error/exception.dart' show ServerException;

import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../../domain/entities/note.dart';
import '../../domain/repositories/note_repository.dart';
import '../datasources/note_remote_data_source.dart';
import '../models/note_model.dart';

class NoteRepositoryImpl implements NoteRepository {
  final NoteRemoteDataSource remoteDataSource;

  NoteRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Note>>> getNotes() async {
    try {
      final notes = await remoteDataSource.getNotes();
      return Right(notes.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Note>> createNote(Note note) async {
    try {
      final noteModel = NoteModel.fromEntity(note);
      final createdNote = await remoteDataSource.createNote(noteModel);
      return Right(createdNote.toEntity());
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteNote(String id) async {
    try {
      await remoteDataSource.deleteNote(id);
      return const Right(null);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}