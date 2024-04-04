import 'package:flutter/material.dart';

Widget normalRow(String data) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(data),
  );
}

tableHeading(String data) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      data,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
    ),
  );
}
