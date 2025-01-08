import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_app/core/constants/app_colors.dart';

class ColumnTodoListTile extends StatelessWidget {
  const ColumnTodoListTile({
    super.key,
    this.onEdit,
    this.creationDate,
    this.onDelete,
    this.color,
    required this.showList,
    this.height,
  });
  final VoidCallback? onEdit;
  final String? creationDate;
  final VoidCallback? onDelete;
  final Widget showList;
  final Color? color;
  final double? height;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: color == Colors.white
              ? Border.all(color: Colors.black, width: 1) // Add black border
              : null, // No border for other colors
          color: color,
        ),
        width: width,
        height: height,
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
                      size: 22,
                    )),
                IconButton(
                    onPressed: onEdit,
                    icon: const Icon(
                      Icons.edit,
                      size: 22,
                    ))
              ],
            ),
            showList,
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                creationDate!,
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
