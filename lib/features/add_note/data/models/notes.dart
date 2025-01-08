import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  final String id;
  final String title;
  final String content;
  final int? color;
  final DateTime? creationDate;

  Note({
    required this.id,
    required this.title,
    required this.content,
    this.color,
    this.creationDate,
  });

  factory Note.fromFirestore(Map<String, dynamic> data, String id) {
    return Note(
      id: id,
      title: data['title'] ?? '',
      content: data['content'] ?? '',
      color: data['color'] as int?,
      creationDate: (data['creationDate'] as Timestamp?)?.toDate(),
    );
  }
}
