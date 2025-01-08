import 'package:flutter/material.dart';
import 'package:habit_app/core/constants/app_colors.dart';
import 'package:habit_app/core/custom_widgets/Appbar_widget.dart';
import 'package:habit_app/core/custom_widgets/app_button.dart';
import 'package:habit_app/core/custom_widgets/color_picker_widget.dart';
import 'package:habit_app/features/todo/domain/todo_service.dart';
import 'package:habit_app/features/todo/presentation/widgets/todo_item.dart';

class ToDoPage extends StatefulWidget {
  final String? documentId; // For editing an existing to-do list
  final List<Map<String, dynamic>>? existingTodos; // Pre-existing todos

  const ToDoPage({
    super.key,
    this.documentId,
    this.existingTodos,
  });

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  final TodoService _todoService = TodoService(); // Service for CRUD operations
  Color _selectedColor = AppColors.choiceColor1; // Default color for to-dos

  final TextEditingController todoController =
      TextEditingController(); // Controller for the TextField

  // List to store todos as maps with text and other properties
  List<Map<String, dynamic>> todos = [];

  @override
  void initState() {
    super.initState();
    // If existing todos are passed, copy them into the local list
    if (widget.existingTodos != null) {
      todos = List.from(widget.existingTodos!);
    }
  }

  @override
  void dispose() {
    todoController.dispose(); // Dispose of the controller to free resources
    super.dispose();
  }

  // Adds a new to-do to the list
  void _addTodo() {
    String todoText = todoController.text.trim();
    if (todoText.isNotEmpty) {
      setState(() {
        todos.add({'text': todoText});
      });
      todoController.clear(); // Clear the input field
    }
  }

  // Saves or updates the to-do list in Firebase
  Future<void> _saveTodoList() async {
    if (todos.isNotEmpty) {
      try {
        if (widget.documentId != null) {
          // Update the existing to-do list
          await _todoService.updateTodoList(
            widget.documentId!,
            todos,
            _selectedColor.value,
          );
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('To-Do List updated successfully!')),
          );
        } else {
          // Add a new to-do list
          await _todoService.addTodoList(todos, _selectedColor.value);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('To-Do List saved successfully!')),
          );
        }
        Navigator.pop(context); // Navigate back after saving
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save the list: $e')),
        );
      }
    } else {
      // If no to-dos are added, show a warning
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add at least one to-do item.')),
      );
    }
  }

  // Displays the color picker dialog
  Future<void> colourPicker(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => ColourPickerWidget(
        onColorSelected: (color) {
          setState(() {
            _selectedColor = color;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height; // Get screen height

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppbarWidget(
        backgroundColor: AppColors.whiteColor,
        title: const Padding(
          padding: EdgeInsets.only(left: 15.0),
          child: Text('Add To-do'),
        ),
        titleTextStyle: const TextStyle(
            color: AppColors.blackColor,
            fontWeight: FontWeight.w700,
            fontFamily: 'Roboto',
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
                flex: 85, // 85% of the available space
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: SizedBox(
                          height: height * 0.1, // Fixed height for the input
                          child: ListTile(
                            horizontalTitleGap: 12,
                            contentPadding: const EdgeInsets.only(left: 0),
                            leading: IconButton(
                              onPressed:
                                  _addTodo, // Add new to-do on button press
                              icon: const Icon(
                                Icons.add,
                                color: Colors.black26,
                              ),
                            ),
                            title: TextField(
                              autofocus: true,
                              keyboardType: TextInputType.multiline,
                              maxLines: null, // Allow multi-line input
                              controller: todoController,
                              textInputAction: TextInputAction.next,
                              style: const TextStyle(
                                fontSize: 19,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w400,
                              ),
                              decoration: const InputDecoration.collapsed(
                                hintText: 'Type something...',
                                hintStyle: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: 19,
                                    fontWeight: FontWeight.w400),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Display list of todos
                      SizedBox(
                        height: height * 0.9, // Height for the list
                        child: ListView.builder(
                          itemCount: todos.length, // Number of to-do items
                          physics:
                              const NeverScrollableScrollPhysics(), // Prevent scrolling
                          itemBuilder: (context, index) {
                            return ToDoItem(
                              todoText: todos[index]
                                  ['text'], // Display todo text
                              onDeletePressed: () {
                                setState(() {
                                  todos
                                      .removeAt(index); // Remove item on delete
                                });
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 15, // 15% of the available space
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppButton(
                      buttonText: widget.documentId == null
                          ? 'Add Todo'
                          : 'Save Changes', // Button text based on mode
                      onTap: () async {
                        await colourPicker(context); // Show color picker
                        _saveTodoList(); // Save the to-do list
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
}
