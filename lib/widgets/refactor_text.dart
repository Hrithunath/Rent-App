import 'package:flutter/material.dart';

Widget buildLabeledText(String label, String text) {
  return Expanded(
    child: Row(
      children: [
        Text(
          '$label: ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    ),
  );
}