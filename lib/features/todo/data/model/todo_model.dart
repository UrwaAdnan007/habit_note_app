import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  final String text;
  bool completed;
  final int color; // Color as ARGB integer
  final DateTime creationDate;

  Todo({
    required this.text,
    this.completed = false,
    this.color = 0xFFFFFFFF, // Default color (white)
    required this.creationDate,
  });

  // Factory method to create a Todo from a map (for Firestore)
  factory Todo.fromMap(Map<String, dynamic> data) {
    return Todo(
      text: data['text'],
      completed: data['completed'] ?? false,
      color: data['color'] ?? 0xFFFFFFFF, // Default to white if color is null
      creationDate: (data['creationDate'] as Timestamp)
          .toDate(), // Convert Firestore timestamp to DateTime
    );
  }

  // Method to convert a Todo object to a map (for Firestore)
  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'completed': completed,
      'color': color,
      'creationDate': creationDate,
    };
  }
}
