import '../../../../core/error/exception.dart';
import '../../../../core/network/network_info.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Importar para usar json.encode
import '../models/note_model.dart';

abstract class NoteRemoteDataSource {
  Future<List<NoteModel>> getNotes();
  Future<NoteModel> createNote(NoteModel note);
  Future<void> deleteNote(String id);
}

class NoteRemoteDataSourceImpl implements NoteRemoteDataSource {
  final http.Client client;
  final NetworkInfo networkInfo;
  final String baseUrl = 'http://localhost:3000'; // Tu base URL

  NoteRemoteDataSourceImpl({
    required this.client,
    required this.networkInfo,
  });

  @override
  Future<List<NoteModel>> getNotes() async {
    final connected = await networkInfo.isConnected();
    if (!connected) {
      throw ServerException('No internet connection');
    }

    final response = await client.get(
      Uri.parse('$baseUrl/api/notas'), // TU RUTA GET
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      // Parsear la respuesta real de tu API
      final List<dynamic> responseData = json.decode(response.body);
      return responseData.map((jsonNote) => NoteModel.fromJson(jsonNote)).toList();
    } else {
      throw ServerException('Failed to load notes: ${response.statusCode}');
    }
  }

  @override
  Future<NoteModel> createNote(NoteModel note) async {
    final connected = await networkInfo.isConnected();
    if (!connected) {
      throw ServerException('No internet connection');
    }

    // Mapear tu modelo a la estructura que espera tu API
    final Map<String, dynamic> requestBody = {
      "titulo": note.title,
      "parrafo": note.content,
      "estatus": "en-progreso" // Valor por defecto según tu ejemplo
    };

    final response = await client.post(
      Uri.parse('$baseUrl/api/notas'), // TU RUTA POST
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(requestBody),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      // Parsear la respuesta y retornar la nota creada
      final Map<String, dynamic> responseData = json.decode(response.body);
      return NoteModel.fromJson(responseData);
    } else {
      throw ServerException('Failed to create note: ${response.statusCode}');
    }
  }

  @override
  Future<void> deleteNote(String id) async {
    final connected = await networkInfo.isConnected();
    if (!connected) {
      throw ServerException('No internet connection');
    }

    final response = await client.delete(
      Uri.parse('$baseUrl/api/notas/$id'), // TU RUTA DELETE
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw ServerException('Failed to delete note: ${response.statusCode}');
    }
  }
}