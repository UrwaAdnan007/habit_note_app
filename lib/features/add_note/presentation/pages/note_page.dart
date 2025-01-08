import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_app/core/constants/app_colors.dart';
import 'package:habit_app/core/custom_widgets/Appbar_widget.dart';
import 'package:habit_app/core/custom_widgets/app_button.dart';
import 'package:habit_app/core/custom_widgets/color_picker_widget.dart';

class NotePage extends StatefulWidget {
  const NotePage({
    super.key,
    this.noteId,
    this.initialTitle,
    this.initialContent,
  });
  final String? noteId; // Pass this when updating
  final String? initialTitle; // Pass this to pre-fill title
  final String? initialContent; // Pass this to pre-fill content

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  Color _selectedColor = AppColors.choiceColor1; // Default color
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  final CollectionReference notesCollection = FirebaseFirestore.instance
      .collection('users') // Users collection
      .doc(FirebaseAuth.instance.currentUser!.uid) // Current user document
      .collection('notes'); // Notes subcollection

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Pre-fill fields if updating
    if (widget.noteId != null) {
      titleController.text = widget.initialTitle ?? '';
      contentController.text = widget.initialContent ?? '';
    }
  }

  Future<void> _saveNote() async {
    String title = titleController.text.trim();
    String content = contentController.text.trim();

    if (title.isNotEmpty && content.isNotEmpty) {
      try {
        if (widget.noteId == null) {
          // Add new note
          await notesCollection.add({
            'title': title,
            'content': content,
            'creationDate': FieldValue.serverTimestamp(),
            'color': _selectedColor.value, // Store selected color
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Note added successfully!')),
          );
        } else {
          // Update existing note
          await notesCollection.doc(widget.noteId).update({
            'title': title,
            'content': content,
            'lastUpdated': FieldValue.serverTimestamp(),
            'color': _selectedColor.value, // Update color
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Note updated successfully!')),
          );
        }

        // Clear fields and navigate back
        titleController.clear();
        contentController.clear();
        if (mounted) Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving note: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter both title and content')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppbarWidget(
        backgroundColor: AppColors.whiteColor,
        title: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(
            widget.noteId == null ? 'Add Note' : 'Update Note',
          ),
        ),
        titleTextStyle: GoogleFonts.roboto(
            color: AppColors.blackColor,
            fontWeight: FontWeight.w500,
            fontSize: 20),
        leading: Transform.translate(
          offset: const Offset(20.0, 0.0),
          child: BackButton(
            color: AppColors.appColor,
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Expanded(
                flex: 85,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 41.0),
                        child: TextField(
                          autofocus: true,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          controller: titleController,
                          textInputAction: TextInputAction.next,
                          style: GoogleFonts.nunito(
                              fontSize: 30, fontWeight: FontWeight.w400),
                          decoration: InputDecoration.collapsed(
                            hintText: 'Title',
                            hintStyle: GoogleFonts.nunito(
                                fontSize: 44, fontWeight: FontWeight.w400),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: TextField(
                          autofocus: true,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          controller: contentController,
                          textInputAction: TextInputAction.next,
                          style: GoogleFonts.nunito(
                            fontSize: 19,
                            fontWeight: FontWeight.w400,
                          ),
                          decoration: InputDecoration.collapsed(
                            hintText: 'Type something...',
                            hintStyle: GoogleFonts.nunito(
                                fontSize: 19, fontWeight: FontWeight.w400),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 15,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppButton(
                      buttonText:
                          widget.noteId == null ? 'Add Note' : 'Update Note',
                      onTap: () async {
                        await colourPicker(context);
                        _saveNote();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> colourPicker(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => ColourPickerWidget(
              onColorSelected: (color) {
                setState(() {
                  _selectedColor = color;
                });
              },
            ));
  }
}
