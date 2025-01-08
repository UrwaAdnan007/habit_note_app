import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NoteService {
  // Get the current user UID
  final String userId = FirebaseAuth.instance.currentUser!.uid;

  // Get the user's notes subcollection reference
  CollectionReference get notesCollection => FirebaseFirestore.instance
      .collection('users') // Main collection
      .doc(userId) // Document for the current user
      .collection('notes'); // Subcollection for notes

  // CREATE a new note
  Future<void> addNote(String title, String content, int color) async {
    try {
      await notesCollection.add({
        'title': title,
        'content': content,
        'creationDate': FieldValue.serverTimestamp(),
        'userId': FirebaseAuth.instance.currentUser?.uid,
        'color': color,
      });
    } catch (e) {
      print('Error adding note: $e');
    }
  }

  // READ (fetch all notes as a stream)
  Stream<QuerySnapshot> getNotesStream() {
    return notesCollection
        .orderBy('creationDate', descending: true)
        .snapshots();
  }

  // READ (fetch a single note by ID)
  Future<DocumentSnapshot> getNoteById(String noteId) async {
    return await notesCollection.doc(noteId).get();
  }

  // UPDATE a note
  Future<void> updateNote(
      String noteId, String title, String content, int color) async {
    try {
      await notesCollection.doc(noteId).update({
        'title': title,
        'content': content,
        'color': color,
      });
    } catch (e) {
      print('Error updating note: $e');
    }
  }

  // DELETE a note
  Future<void> deleteNote(String noteId) async {
    try {
      await notesCollection.doc(noteId).delete();
    } catch (e) {
      print('Error deleting note: $e');
    }
  }
}
