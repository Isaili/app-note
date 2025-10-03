import 'package:flutter/material.dart';
import '../../domain/entities/note.dart';

class NoteCard extends StatefulWidget {
  final Note note;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const NoteCard({
    Key? key,
    required this.note,
    required this.onDelete,
    required this.onTap,
  }) : super(key: key);

  @override
  _NoteCardState createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(_isHovered ? 0.2 : 0.1),
              blurRadius: _isHovered ? 10 : 5,
              offset: Offset(0, _isHovered ? 4 : 2),
            ),
          ],
          border: Border.all(
            color: Colors.blue.withOpacity(_isHovered ? 0.5 : 0.2),
            width: _isHovered ? 2 : 1,
          ),
        ),
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: 'note-${widget.note.id}',
                      child: Material(
                        color: Colors.transparent,
                        child: Text(
                          widget.note.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[800],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      widget.note.content,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                        height: 1.4,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 12),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.access_time, size: 12, color: Colors.blue[600]),
                          SizedBox(width: 4),
                          Text(
                            'Actualizado: ${_formatDate(widget.note.updatedAt)}',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.blue[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(_isHovered ? 0.9 : 0.7),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.delete, color: Colors.white, size: 16),
                    onPressed: widget.onDelete,
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}