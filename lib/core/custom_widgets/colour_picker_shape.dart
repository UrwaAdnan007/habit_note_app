import 'package:flutter/material.dart';

class ColorPickerShape extends StatelessWidget {
  const ColorPickerShape({
    super.key,
    required this.choicecolors,
    required this.onTap,
  });
  final Color choicecolors;
  final VoidCallback onTap; // To handle the tap event
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: choicecolors,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(50),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 210),
              opacity: 1.0,
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey)),
              ),
            ),
          ),
        ));
  }
}
