import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_app/core/constants/app_colors.dart';

class RowTodoListTile extends StatelessWidget {
  const RowTodoListTile({
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
        height: height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
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
            showList,
            Text(
              creationDate!,
              style: GoogleFonts.roboto(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: AppColors.blackColor),
            ),
          ],
        ),
      ),
    );
  }
}
