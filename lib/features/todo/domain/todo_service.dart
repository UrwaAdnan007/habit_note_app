import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TodoService {
  // Get the current user UID
  final String userId = FirebaseAuth.instance.currentUser!.uid;

  // Get the user's  todos subcollection reference
  CollectionReference get _todoCollection => FirebaseFirestore.instance
      .collection('users') // Main collection
      .doc(userId) // Document for the current user
      .collection('todoLists'); //subcollection for todos

  // Add a new to-do list
  Future<void> addTodoList(List<Map<String, dynamic>> todos, int color) async {
    try {
      await _todoCollection.add({
        'todos': todos,
        'userId': FirebaseAuth.instance.currentUser?.uid,
        'creationDate': FieldValue.serverTimestamp(),
        'color': color,
      });
    } catch (e) {
      throw Exception('Failed to add todo list: $e');
    }
  }

  // Fetch all to-do lists
  Stream<QuerySnapshot> getTodoLists() {
    return _todoCollection
        .orderBy('creationDate', descending: true)
        .snapshots();
  }

  // Update a specific to-do list
  Future<void> updateTodoList(
    String docId,
    List<Map<String, dynamic>> updatedTodos,
    int color,
  ) async {
    try {
      await _todoCollection.doc(docId).update({
        'todos': updatedTodos,
        'color': color,
      });
    } catch (e) {
      throw Exception('Failed to update todo list: $e');
    }
  }

  // Delete a specific to-do list
  Future<void> deleteTodoList(String documentId) async {
    try {
      // Firestore mein se document delete karein
      await FirebaseFirestore.instance
          .collection('todoLists')
          .doc(documentId)
          .delete();
      print('To-Do List deleted successfully!');
    } catch (e) {
      print('Error deleting To-Do List: $e');
    }
  }
}
