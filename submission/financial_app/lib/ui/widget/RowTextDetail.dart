import 'package:flutter/material.dart';

class RowTextDetail extends StatelessWidget {
  final String title;
  final String detail;

  const RowTextDetail({super.key, required this.title, required this.detail});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12
          ),
        ),
        const Spacer(),
        Text(
          detail,
          style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.right,
        )
      ],
    );
  }
}
