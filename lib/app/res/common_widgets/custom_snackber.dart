import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void showCustomBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    backgroundColor: Colors.purple.shade300, // Adjust color to match design
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildSheetItem(Icons.bookmark_border, "Save post"),
            buildSheetItem(Icons.link, "Copy link"),
            buildSheetItem(Icons.visibility_off, "Hide post"),
            buildSheetItem(Icons.person_remove, "Unfollow"),
            buildSheetItem(Icons.block, "Block David Wavy", isDestructive: true),
            buildSheetItem(Icons.flag, "Report profile", isDestructive: true),
          ],
        ),
      );
    },
  );
}

Widget buildSheetItem(IconData icon, String title, {bool isDestructive = false}) {
  return ListTile(
    leading: Icon(icon, color: isDestructive ? Colors.red : Colors.white),
    title: Text(
      title,
      style: TextStyle(color: isDestructive ? Colors.red : Colors.white),
    ),
    onTap: () {
      Get.snackbar("Action", "$title selected", snackPosition: SnackPosition.BOTTOM);
    },
  );
}

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("Custom Snackbar")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showCustomBottomSheet(Get.context!);
          },
          child: Text("Show Bottom Sheet"),
        ),
      ),
    ),
  ));
}
