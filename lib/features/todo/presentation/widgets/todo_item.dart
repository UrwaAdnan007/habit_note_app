import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_app/core/constants/app_colors.dart';

class ToDoItem extends StatelessWidget {
  const ToDoItem(
      {super.key, required this.todoText, required this.onDeletePressed});
  final String todoText;

  final VoidCallback onDeletePressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 22,
      title: Text(
        todoText,
        style: GoogleFonts.inter(fontWeight: FontWeight.w400, fontSize: 16),
      ),
      trailing: IconButton(
          onPressed: onDeletePressed,
          icon: const Icon(
            Icons.delete,
            color: AppColors.greyColor,
          )),
    );
  }
}
