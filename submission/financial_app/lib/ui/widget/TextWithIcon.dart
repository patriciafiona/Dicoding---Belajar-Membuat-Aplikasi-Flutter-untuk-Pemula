import 'package:flutter/material.dart';

class TextWithIcon extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String text;
  final double textSize;
  final Color textColor;

  const TextWithIcon({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.text,
    required this.textSize,
    required this.textColor
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
              color: textColor,
              fontSize: textSize,
              fontWeight: FontWeight.bold
          ),
        ),
      ],
    );
  }
}
