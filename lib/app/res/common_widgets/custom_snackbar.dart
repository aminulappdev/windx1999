// import 'package:flutter/material.dart';

// void showSnackBarMessage(BuildContext context, String msg,
//     [bool isError = false]) {
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: Text(msg),
//       backgroundColor: isError ? const Color.fromARGB(255, 82, 81, 81) : const Color.fromARGB(153, 135, 237, 138),
//     ),
//   );
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackBarMessage(BuildContext context, String msg,
    [bool isError = false]) {
  Get.snackbar(
    isError ? 'Failed' : 'Success', // Title based on isError
    msg, // Message
    backgroundColor: isError ? const Color.fromARGB(207, 255, 82, 82) : const Color.fromARGB(255, 222, 214, 233),
    colorText: Colors.black, // Text color for better visibility
    snackPosition: SnackPosition.TOP, // Position at bottom
    margin: EdgeInsets.all(16), // Margin for better appearance
    borderRadius: 8, // Rounded corners
    duration: Duration(seconds: 3), // Duration of snackbar
  );
}
