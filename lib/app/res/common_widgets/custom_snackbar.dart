import 'package:flutter/material.dart';

void showSnackBarMessage(BuildContext context, String msg,
    [bool isError = false]) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(msg),
      backgroundColor: isError ? const Color.fromARGB(255, 82, 81, 81) : const Color.fromARGB(153, 135, 237, 138),
    ),
  );
}