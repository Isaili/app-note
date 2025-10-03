import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

// Core
import 'core/network/network_info.dart';

// Features
import 'features/notes/data/datasources/note_remote_data_source.dart';
import 'features/notes/data/repositories/note_repository_impl.dart';
import 'features/notes/domain/repositories/note_repository.dart';
import 'features/notes/domain/usecases/get_notes.dart';
import 'features/notes/domain/usecases/create_note.dart';
import 'features/notes/domain/usecases/delete_note.dart';
import 'features/notes/presentation/pages/notes_list_page.dart';
import 'features/notes/presentation/providers/notes_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Dependencias core
        Provider<http.Client>(create: (_) => http.Client()),
        Provider<NetworkInfo>(create: (_) => NetworkInfoImpl(Connectivity())),
        
        // Data sources
        Provider<NoteRemoteDataSource>(
          create: (context) => NoteRemoteDataSourceImpl(
            client: context.read<http.Client>(),
            networkInfo: context.read<NetworkInfo>(),
          ),
        ),
        
        // Repository
        Provider<NoteRepository>(
          create: (context) => NoteRepositoryImpl(
            remoteDataSource: context.read<NoteRemoteDataSource>(),
          ),
        ),
        
        // Use cases
        Provider<GetNotes>(
          create: (context) => GetNotes(context.read<NoteRepository>()),
        ),
        Provider<CreateNote>(
          create: (context) => CreateNote(context.read<NoteRepository>()),
        ),
        Provider<DeleteNote>(
          create: (context) => DeleteNote(context.read<NoteRepository>()),
        ),
        
        // Provider (ViewModel)
        ChangeNotifierProvider<NotesProvider>(
          create: (context) => NotesProvider(
            getNotes: context.read<GetNotes>(),
            createNote: context.read<CreateNote>(),
            deleteNote: context.read<DeleteNote>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'App de Notas',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Roboto',
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.blue.shade800,
            foregroundColor: Colors.white,
          ),
        ),
        home: NotesListPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}