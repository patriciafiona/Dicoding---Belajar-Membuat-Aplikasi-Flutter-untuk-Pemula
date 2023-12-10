import 'package:flutter/material.dart';

class RoundedButtonWithText extends StatefulWidget {
  final String title;
  final Color textColor;

  final Color buttonColor;
  final Color iconColor;
  final IconData icon;

  final Function onPressAction;

  const RoundedButtonWithText({
    super.key,
    required this.title,
    required this.icon,
    required this.textColor,
    required this.buttonColor,
    required this.iconColor,
    required this.onPressAction
  });

  @override
  State<RoundedButtonWithText> createState() => _RoundedButtonWithTextState();
}

class _RoundedButtonWithTextState extends State<RoundedButtonWithText> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => widget.onPressAction(),
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(20),
            backgroundColor: widget.buttonColor, // <-- Button color
            foregroundColor: widget.iconColor, // <-- Splash color
          ),
          child: Icon(
              widget.icon,
              color: widget.iconColor
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            widget.title,
            style: TextStyle(
                color: widget.textColor,
                fontSize: 14
            ),
          ),
        )
      ],
    );
  }
}
