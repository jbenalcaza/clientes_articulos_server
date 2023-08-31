import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CustomButtom extends StatelessWidget {
  const CustomButtom(
      {Key? key, required this.onPressed, required this.text, this.color})
      : super(key: key);
  final Function() onPressed;
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Container(
        decoration: BoxDecoration(
          //color: color,
          borderRadius: BorderRadius.circular(7),
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
          ),
          child: Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
