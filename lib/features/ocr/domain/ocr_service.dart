import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OCRService {
  // Get the current user UID
  final String userId = FirebaseAuth.instance.currentUser!.uid;

  // Get the user's notes subcollection reference
  CollectionReference get notesCollection => FirebaseFirestore.instance
      .collection('users') // Main collection
      .doc(userId) // Document for the current user
      .collection('notes'); // Subcollection for notes

  // creating new note for ocr text //
  Future<void> addOCRNote(String ocrText, int color) async {
    try {
      await notesCollection.add({
        'title': 'OCR', // Title set //
        'content': ocrText, // The extracted text from ocr//
        'creationDate':
            FieldValue.serverTimestamp(), // Storing the creation date//
        'userId': FirebaseAuth
            .instance.currentUser?.uid, // User ID of the logged-in user //
        'color': color, // Store color as int //
      });
    } catch (e) {
      print('Error adding OCR note: $e');
    }
  }

  // read (fetch all OCR notes as a stream)
  Stream<QuerySnapshot> getOCRNotesStream() {
    return notesCollection
        .where('title', isEqualTo: 'OCR') // Filter to fetch only OCR notes
        .orderBy('creationDate', descending: true)
        .snapshots();
  }

  // read (fetch a single OCR note by ID)
  Future<DocumentSnapshot> getOCRNoteById(String noteId) async {
    return await notesCollection.doc(noteId).get();
  }

  // update an OCR note
  Future<void> updateOCRNote(String noteId, String ocrText, int color) async {
    try {
      await notesCollection.doc(noteId).update({
        'content': ocrText, // Update OCR content
        'color': color, // Update color
      });
    } catch (e) {
      print('Error updating OCR note: $e');
    }
  }

  // delete an OCR note
  Future<void> deleteOCRNote(String noteId) async {
    try {
      await notesCollection.doc(noteId).delete();
    } catch (e) {
      print('Error deleting OCR note: $e');
    }
  }
}
