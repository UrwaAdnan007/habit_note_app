import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ToDoItem extends StatelessWidget {
  const ToDoItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 22,
      title: Text(
        'dd',
        style: GoogleFonts.inter(fontWeight: FontWeight.w400, fontSize: 18),
      ),
      leading: Icon(Icons.check_box_outline_blank),
    );
  }
}
