import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/notes_provider.dart';
import '../widgets/note_card.dart';
import '../widgets/add_note_dialog.dart';

class NotesListPage extends StatefulWidget {
  @override
  _NotesListPageState createState() => _NotesListPageState();
}

class _NotesListPageState extends State<NotesListPage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NotesProvider>().loadNotes();
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: 'app-title',
          child: Material(
            color: Colors.transparent,
            child: Text(
              'Mis Notas',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.blue[800],
        elevation: 4,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              context.read<NotesProvider>().loadNotes();
              _animationController.reset();
              _animationController.forward();
            },
          ),
        ],
      ),
      body: Consumer<NotesProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Cargando notas...'),
                ],
              ),
            );
          }

          if (provider.error.isNotEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.red),
                  SizedBox(height: 16),
                  Text(
                    provider.error,
                    style: TextStyle(fontSize: 16, color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      provider.loadNotes();
                      _animationController.reset();
                      _animationController.forward();
                    },
                    child: Text('Reintentar'),
                  ),
                ],
              ),
            );
          }

          return FadeTransition(
            opacity: _fadeAnimation,
            child: _buildNotesContent(provider),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddNoteDialog(context),
        child: Icon(Icons.add),
        backgroundColor: Colors.blue[800],
        heroTag: 'add_note_fab',
      ),
    );
  }

  Widget _buildNotesContent(NotesProvider provider) {
    // VIEW OPTION: GridView o ListView basado en preferencia
    final bool useGridView = false; // Cambiar a true para GridView

    if (provider.notes.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.note_add, size: 80, color: Colors.grey[400]),
            SizedBox(height: 16),
            Text(
              'No hay notas',
              style: TextStyle(fontSize: 20, color: Colors.grey[600]),
            ),
            SizedBox(height: 8),
            Text(
              'Presiona el botón + para crear una nueva nota',
              style: TextStyle(fontSize: 14, color: Colors.grey[500]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    if (useGridView) {
      return _buildGridView(provider);
    } else {
      return _buildCustomScrollView(provider);
    }
  }

  Widget _buildCustomScrollView(NotesProvider provider) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 100,
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.blue[800]!, Colors.purple[700]!],
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    '${provider.notes.length} notas',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          collapsedHeight: 60,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final note = provider.notes[index];
              return NoteCard(
                note: note,
                onDelete: () => _deleteNote(context, note.id),
                onTap: () => _showNoteDetails(context, note),
              );
            },
            childCount: provider.notes.length,
          ),
        ),
      ],
    );
  }

  Widget _buildGridView(NotesProvider provider) {
    return GridView.builder(
      padding: EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemCount: provider.notes.length,
      itemBuilder: (context, index) {
        final note = provider.notes[index];
        return NoteCard(
          note: note,
          onDelete: () => _deleteNote(context, note.id),
          onTap: () => _showNoteDetails(context, note),
        );
      },
    );
  }

  void _showAddNoteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AddNoteDialog(
        onSave: (title, content) {
          context.read<NotesProvider>().addNote(title, content);
          _animationController.reset();
          _animationController.forward();
        },
      ),
    );
  }

  void _deleteNote(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Eliminar Nota'),
        content: Text('¿Estás seguro de que quieres eliminar esta nota?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              context.read<NotesProvider>().removeNote(id);
              Navigator.of(context).pop();
              _animationController.reset();
              _animationController.forward();
            },
            child: Text(
              'Eliminar',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _showNoteDetails(BuildContext context, note) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: _NoteDetailsPage(note: note),
          );
        },
      ),
    );
  }
}

// Página de detalles con Hero animation
class _NoteDetailsPage extends StatelessWidget {
  final dynamic note;

  const _NoteDetailsPage({required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: 'note-title-${note.id}',
          child: Material(
            color: Colors.transparent,
            child: Text(
              'Detalles de la Nota',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        backgroundColor: Colors.blue[800],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'note-${note.id}',
              child: Material(
                color: Colors.transparent,
                child: Text(
                  note.title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800],
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  note.content,
                  style: TextStyle(fontSize: 16, height: 1.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}