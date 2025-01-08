import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_app/features/note_editor/presentation/widgets/row_notes_listtile.dart';
import 'package:habit_app/features/todo/domain/todo_service.dart';
import 'package:habit_app/features/note_editor/presentation/widgets/column_todo_listtile.dart';
import 'package:habit_app/features/note_editor/presentation/widgets/row_todo_listitle.dart';
import 'package:intl/intl.dart';

import 'package:habit_app/core/constants/app_colors.dart';
import 'package:habit_app/core/custom_widgets/Appbar_widget.dart';
import 'package:habit_app/core/custom_widgets/custom_dialog.dart';
import 'package:habit_app/core/custom_widgets/floating_button.dart';
import 'package:habit_app/features/add_note/data/models/notes.dart';
import 'package:habit_app/features/add_note/domain/note_service.dart';
import 'package:habit_app/features/add_note/presentation/pages/note_page.dart';
import 'package:habit_app/features/note_editor/presentation/widgets/column_notes_listtile.dart';
import 'package:habit_app/features/note_editor/presentation/widgets/drawer_widget.dart';
import 'package:habit_app/features/note_editor/presentation/widgets/filter_by_colour_widget.dart';
import 'package:habit_app/features/todo/presentation/pages/todo_page.dart';

class NoteEditorPage extends StatefulWidget {
  const NoteEditorPage({super.key});
  @override
  State<NoteEditorPage> createState() => _NoteEditorPageState();
}

class _NoteEditorPageState extends State<NoteEditorPage> {
  final NoteService noteService = NoteService();
  final TodoService todoService = TodoService();
  bool isColumnView = true;
  Color? selectedColor;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final notesStream = FirebaseFirestore.instance
        .collection('users') // users collection
        .doc(FirebaseAuth.instance.currentUser?.uid) // current user's doc
        .collection('notes') // notes subcollection
        .snapshots();

    final todosStream = FirebaseFirestore.instance
        .collection('users') // users collection
        .doc(FirebaseAuth.instance.currentUser?.uid) // current user's doc
        .collection('todoLists') // todos subcollection
        .snapshots();

    final ocrNotesStream = FirebaseFirestore.instance
        .collection('users') // users collection
        .doc(FirebaseAuth.instance.currentUser?.uid) // current user's doc
        .collection('ocrNotes') // notes subcollection
        .snapshots();

    return SafeArea(
      child: Scaffold(
        drawer: const DrawerWidget(),
        appBar: AppbarWidget(
          iconTheme: const IconThemeData(color: AppColors.appColor),
          backgroundColor: AppColors.whiteColor,
          title: Text(
            'Notes & To-Dos',
            style:
                GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 20),
          ),
          actions: [
            IconButton(
              onPressed: () => _openColorFilterDialog(),
              icon: Image.asset('assets/icons/color_lens.png'),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 24),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    isColumnView = !isColumnView;
                  });
                },
                icon: isColumnView
                    ? Image.asset('assets/icons/gridview_icon.png')
                    : Image.asset('assets/icons/listview_icon.png'),
              ),
            ),
          ],
          automaticallyImplyLeading: true,
        ),
        backgroundColor: AppColors.whiteColor,
        body: StreamBuilder3<
            QuerySnapshot<Map<String, dynamic>>,
            QuerySnapshot<Map<String, dynamic>>,
            QuerySnapshot<Map<String, dynamic>>>(
          stream1: notesStream,
          stream2: todosStream,
          stream3: ocrNotesStream,
          builder: (context, notesSnapshot, todosSnapshot, ocrNotesSnapshot) {
            if (notesSnapshot.connectionState == ConnectionState.waiting ||
                todosSnapshot.connectionState == ConnectionState.waiting ||
                ocrNotesSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (notesSnapshot.hasError ||
                todosSnapshot.hasError ||
                ocrNotesSnapshot.hasError) {
              return Center(
                child: Text(
                  "Error loading data: ${notesSnapshot.error ?? todosSnapshot.error}",
                ),
              );
            }

            // Notes and To-Dos data
            final notes = notesSnapshot.data?.docs.map((doc) {
              return {
                'type': 'note',
                'data': Note.fromFirestore(doc.data(), doc.id)
              };
            }).toList();

            final todos = todosSnapshot.data?.docs.map((doc) {
              return {
                'type': 'todo',
                'data': doc.data(),
                'id': doc.id, // Store document ID here
              };
            }).toList();
            final ocrNotes = ocrNotesSnapshot.data?.docs.map((doc) {
              return {'type': 'ocrNote', 'data': doc.data(), 'id': doc.id};
            }).toList();

            // Combine notes and todos
            final combinedList = [...?notes, ...?todos, ...?ocrNotes];

            if (combinedList.isEmpty) {
              return SizedBox(
                width: width,
                height: height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/note_editor_bgimg.png'),
                    const Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Text(
                        'Create your first note or to-do!',
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 20,
                          fontFamily: 'Roboto',
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 12),
              child: isColumnView
                  ? ListView.builder(
                      itemCount: combinedList.length,
                      itemBuilder: (context, index) {
                        final item = combinedList[index];

                        if (item['type'] == 'note') {
                          final note = item['data'] as Note;
                          final int colorValue = note.color ?? 0xFFFFFFFF;
                          final Color noteColor = Color(colorValue);
                          final creationDate = note.creationDate;
                          final formattedDate = creationDate != null
                              ? DateFormat.yMMMd().add_jm().format(creationDate)
                              : 'No Date';

                          if (selectedColor != null &&
                              noteColor != selectedColor) {
                            return const SizedBox
                                .shrink(); // If the color doesn't match, return an empty widget
                          }

                          return ColumnNotesListTile(
                            color: noteColor,
                            title: note.title,
                            onDelete: () async {
                              bool confirm =
                                  await _showDeleteConfirmationDialog('Note');
                              if (confirm) {
                                try {
                                  await noteService.deleteNote(note.id);
                                } catch (e) {
                                  log('$e');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text('Error deleting note: $e')),
                                  );
                                }
                              }
                            },
                            creationDate: ' $formattedDate',
                            onEdit: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NotePage(
                                    noteId: note.id,
                                    initialTitle: note.title,
                                    initialContent: note.content,
                                  ),
                                ),
                              );
                            },
                          );
                        } else if (item['type'] == 'todo') {
                          final todoData = item['data'] as Map<String, dynamic>;
                          final todos = List<Map<String, dynamic>>.from(
                              todoData['todos'] ?? []);

                          final colorValue = todoData['color'] ??
                              Colors.white.value; // Default to white
                          final creationTimestamp =
                              todoData['creationDate'] as Timestamp?;
                          final creationDate = creationTimestamp?.toDate();
                          final documentId = item['id']
                              as String; // Extract the ID from the item

                          final formattedDate = creationDate != null
                              ? DateFormat.yMMMd().add_jm().format(creationDate)
                              : 'No Date';

                          if (selectedColor != null &&
                              Color(colorValue) != selectedColor) {
                            return const SizedBox.shrink();
                          }

                          return SingleChildScrollView(
                            child: ColumnTodoListTile(
                                color: Color(colorValue),
                                onDelete: () async {
                                  bool confirm =
                                      await _showDeleteConfirmationDialog(
                                          'Todo-List');
                                  if (confirm) {
                                    await todoService
                                        .deleteTodoList(documentId);
                                  }
                                },
                                creationDate: '$formattedDate',
                                onEdit: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ToDoPage(
                                        documentId: documentId,
                                        existingTodos: todos,
                                      ),
                                    ),
                                  );
                                },
                                showList: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: todos.length,
                                    itemBuilder: (context, index) {
                                      final todo = todos[index];
                                      return Row(
                                        children: [
                                          Checkbox(
                                            value: todo['completed'] ?? false,
                                            onChanged: (newValue) async {
                                              setState(() {
                                                todo['completed'] = newValue;
                                              });
                                              await todoService.updateTodoList(
                                                documentId,
                                                todos,
                                                colorValue,
                                              );
                                            },
                                          ),
                                          Flexible(
                                            child: Text(
                                              todo['text'] as String,
                                              textAlign: TextAlign.start,
                                              overflow: TextOverflow.clip,
                                              maxLines: 3,
                                              softWrap: true,
                                              style: GoogleFonts.roboto(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.blackColor),
                                            ),
                                          ),
                                        ],
                                      );
                                    })),
                          );
                        } else if (item['type'] == 'ocrNote') {
                          final note = item['data'] as Note;
                          final int colorValue = note.color ?? 0xFFFFFFFF;
                          final Color noteColor = Color(colorValue);
                          final creationDate = note.creationDate;
                          final formattedDate = creationDate != null
                              ? DateFormat.yMMMd().add_jm().format(creationDate)
                              : 'No Date';

                          if (selectedColor != null &&
                              noteColor != selectedColor) {
                            return const SizedBox
                                .shrink(); // If the color doesn't match, return an empty widget
                          }

                          return ColumnNotesListTile(
                            color: noteColor,
                            title: note.title,
                            onDelete: () async {
                              bool confirm =
                                  await _showDeleteConfirmationDialog('Note');
                              if (confirm) {
                                try {
                                  await noteService.deleteNote(note.id);
                                } catch (e) {
                                  log('$e');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text('Error deleting note: $e')),
                                  );
                                }
                              }
                            },
                            creationDate: ' $formattedDate',
                            onEdit: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NotePage(
                                    noteId: note.id,
                                    initialTitle: note.title,
                                    initialContent: note.content,
                                  ),
                                ),
                              );
                            },
                          );
                        }

                        return const SizedBox.shrink();
                      },
                    )
                  : MasonryGridView.builder(
                      gridDelegate:
                          const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      shrinkWrap: true,
                      itemCount: combinedList.length,
                      itemBuilder: (context, index) {
                        final item = combinedList[index];

                        if (item['type'] == 'note') {
                          final note = item['data'] as Note;
                          final int colorValue = note.color ?? 0xFFFFFFFF;
                          final Color noteColor = Color(colorValue);
                          final creationDate = note.creationDate;
                          final formattedDate = creationDate != null
                              ? DateFormat.yMMMd().add_jm().format(creationDate)
                              : 'No Date';

                          if (selectedColor != null &&
                              noteColor != selectedColor) {
                            return const SizedBox.shrink();
                          }
                          return RowNotesListTile(
                            color: noteColor,
                            title: note.title,
                            onDelete: () async {
                              bool confirm =
                                  await _showDeleteConfirmationDialog('Note');
                              if (confirm) {
                                try {
                                  await noteService.deleteNote(note.id);
                                } catch (e) {
                                  log('$e');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text('Error deleting note: $e')),
                                  );
                                }
                              }
                            },
                            creationDate: ' $formattedDate',
                            onEdit: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NotePage(
                                    noteId: note.id,
                                    initialTitle: note.title,
                                    initialContent: note.content,
                                  ),
                                ),
                              );
                            },
                          );
                        } else if (item['type'] == 'todo') {
                          final todoData = item['data'] as Map<String, dynamic>;
                          final todos = List<Map<String, dynamic>>.from(
                              todoData['todos'] ?? []);

                          final colorValue =
                              todoData['color'] ?? Colors.white.value;
                          final creationTimestamp =
                              todoData['creationDate'] as Timestamp?;
                          final creationDate = creationTimestamp?.toDate();
                          final documentId = item['id'] as String;

                          final formattedDate = creationDate != null
                              ? DateFormat.yMMMd().add_jm().format(creationDate)
                              : 'No Date';

                          if (selectedColor != null &&
                              Color(colorValue) != selectedColor) {
                            return const SizedBox.shrink();
                          }

                          return SingleChildScrollView(
                            child: RowTodoListTile(
                                color: Color(colorValue),
                                onDelete: () async {
                                  bool confirm =
                                      await _showDeleteConfirmationDialog(
                                          'Todo-List');
                                  if (confirm) {
                                    await todoService
                                        .deleteTodoList(documentId);
                                  }
                                },
                                creationDate: '$formattedDate',
                                onEdit: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ToDoPage(
                                        documentId: documentId,
                                        existingTodos: todos,
                                      ),
                                    ),
                                  );
                                },
                                showList: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: todos.length,
                                    itemBuilder: (context, index) {
                                      final todo = todos[index];
                                      return Row(
                                        children: [
                                          Checkbox(
                                            value: todo['completed'] ?? false,
                                            onChanged: (newValue) async {
                                              setState(() {
                                                todo['completed'] = newValue;
                                              });
                                              await todoService.updateTodoList(
                                                documentId,
                                                todos,
                                                colorValue,
                                              );
                                            },
                                          ),
                                          Flexible(
                                            child: Text(
                                              todo['text'] as String,
                                              textAlign: TextAlign.start,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 3,
                                              softWrap: true,
                                              style: GoogleFonts.roboto(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.blackColor),
                                            ),
                                          ),
                                        ],
                                      );
                                    })),
                          );
                        } else if (item['type'] == 'ocrNote') {
                          final note = item['data'] as Note;
                          final int colorValue = note.color ?? 0xFFFFFFFF;
                          final Color noteColor = Color(colorValue);
                          final creationDate = note.creationDate;
                          final formattedDate = creationDate != null
                              ? DateFormat.yMMMd().add_jm().format(creationDate)
                              : 'No Date';

                          if (selectedColor != null &&
                              noteColor != selectedColor) {
                            return const SizedBox.shrink();
                          }
                          return RowNotesListTile(
                            color: noteColor,
                            title: note.title,
                            onDelete: () async {
                              bool confirm =
                                  await _showDeleteConfirmationDialog('Note');
                              if (confirm) {
                                try {
                                  await noteService.deleteNote(note.id);
                                } catch (e) {
                                  log('$e');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text('Error deleting note: $e')),
                                  );
                                }
                              }
                            },
                            creationDate: ' $formattedDate',
                            onEdit: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NotePage(
                                    noteId: note.id,
                                    initialTitle: note.title,
                                    initialContent: note.content,
                                  ),
                                ),
                              );
                            },
                          );
                        }

                        return const SizedBox.shrink();
                      },
                    ),
            );
          },
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(right: 24.0),
          child: FloatingButtonWidget(
            onTap: () => newNoteDialog(context),
          ),
        ),
      ),
    );
  }

  void newNoteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => MyCustomDialog(
        option1text: 'Add note',
        option2text: 'Add to-do',
        option1Icon: 'assets/icons/keyboard_icon.png',
        option2Icon: 'assets/icons/checkbox_icon.png',
        title: 'New',
        onTap1: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NotePage()),
        ),
        onTap2: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ToDoPage()),
        ),
      ),
    );
  }

  void _openColorFilterDialog() async {
    final color = await showDialog<Color>(
      context: context,
      builder: (context) => FilterByColourWidget(
        onColorTap: (color) {
          setState(() {
            selectedColor = color; // Set selected color
          });
        },
        onTap: () {
          setState(() {
            selectedColor = null;
          });
          Navigator.pop(context);
        },
      ),
    );

    if (color != null) {
      setState(() {
        selectedColor = color;
      });
    }
  }

  Future<bool> _showDeleteConfirmationDialog(String title) async {
    return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  backgroundColor: AppColors.whiteColor,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                  title: Text(
                    'Delete $title',
                    style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w700),
                  ),
                  content: Text(
                    'Are you sure you want to delete this $title?',
                    style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        color: AppColors.greyColor,
                        fontWeight: FontWeight.w400),
                  ),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pop(false); // Close the dialog
                            },
                            style: OutlinedButton.styleFrom(
                              backgroundColor: AppColors.whiteColor,
                              shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      strokeAlign:
                                          BorderSide.strokeAlignOutside,
                                      color: AppColors.blackColor,
                                      width: 3),
                                  borderRadius: BorderRadius.circular(8.0)),
                              fixedSize: const Size(110, 40),
                            ),
                            child: const Text(
                              'Cancel',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                color: AppColors.greyColor,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              Navigator.of(context)
                                  .pop(true); // Close the dialog
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(AppColors.appColor),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(8.0))),
                              fixedSize: MaterialStateProperty.all(
                                  const Size(110, 40)),
                            ),
                            child: const Text(
                              'Delete',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                color: AppColors.whiteColor,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )) ??
        false;
  }
}

class StreamBuilder3<T1, T2, T3> extends StatelessWidget {
  final Stream<T1> stream1;
  final Stream<T2> stream2;
  final Stream<T3> stream3;
  final Widget Function(
          BuildContext, AsyncSnapshot<T1>, AsyncSnapshot<T2>, AsyncSnapshot<T3>)
      builder;

  const StreamBuilder3({
    required this.stream1,
    required this.stream2,
    required this.stream3,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T1>(
      stream: stream1,
      builder: (context, snapshot1) {
        return StreamBuilder<T2>(
          stream: stream2,
          builder: (context, snapshot2) {
            return StreamBuilder<T3>(
              stream: stream3,
              builder: (context, snapshot3) {
                return builder(context, snapshot1, snapshot2, snapshot3);
              },
            );
          },
        );
      },
    );
  }
}
