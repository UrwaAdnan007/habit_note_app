import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_app/core/constants/app_colors.dart';

class RowNotesListTile extends StatelessWidget {
  const RowNotesListTile(
      {super.key,
      required this.title,
      required this.onEdit,
      required this.creationDate,
      required this.onDelete,
      required this.color});
  final String title;
  final VoidCallback onEdit;
  final String creationDate;
  final VoidCallback onDelete;
  final Color color;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: color == Colors.white
              ? Border.all(color: Colors.black, width: 1) // Add black border
              : null, // No border for other colors
          color: color,
        ),
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: onDelete,
                    icon: const Icon(
                      Icons.delete,
                      size: 18,
                    )),
                IconButton(
                    onPressed: onEdit,
                    icon: const Icon(
                      Icons.edit,
                      size: 18,
                    ))
              ],
            ),
            Text(
              title,
              textAlign: TextAlign.start,
              style: GoogleFonts.roboto(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: AppColors.blackColor),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                creationDate,
                style: GoogleFonts.roboto(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: AppColors.blackColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
