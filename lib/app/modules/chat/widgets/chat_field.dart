import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChattingFieldWidget extends StatefulWidget {
  

  const ChattingFieldWidget({super.key,});

  @override
  State<ChattingFieldWidget> createState() => _ChattingFieldWidgetState();
}

class _ChattingFieldWidgetState extends State<ChattingFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Write something',
          hintStyle: TextStyle(color: Colors.grey.shade600),
          prefixIcon: InkWell(
            onTap: () {
              _showAttachmentOptions(context);  // Show the bottom sheet when clicked
            },
            child: Icon(Icons.grid_on, color: Colors.grey.shade600),
          ),
          filled: true,
          fillColor: const Color.fromARGB(137, 255, 255, 255),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.r),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // Function to show the bottom sheet with options
  void _showAttachmentOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Gallery Option
              _buildOptionRow(
                icon: Icons.photo,
                text: 'Gallery',
                onTap: () {
                  // Handle gallery action here
                  Navigator.pop(context); // Close the bottom sheet
                },
              ),
              // Document Option
              _buildOptionRow(
                icon: Icons.description,
                text: 'Document',
                onTap: () {
                  // Handle document action here
                  Navigator.pop(context); // Close the bottom sheet
                },
              ),
              // Contact Option
              _buildOptionRow(
                icon: Icons.contact_page,
                text: 'Contact',
                onTap: () {
                  // Handle contact action here
                  Navigator.pop(context); // Close the bottom sheet
                },
              ),
              // Location Option
              _buildOptionRow(
                icon: Icons.location_on,
                text: 'Location',
                onTap: () {
                  // Handle location action here
                  Navigator.pop(context); // Close the bottom sheet
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Helper function to build a row with icon and text
  Widget _buildOptionRow({required IconData icon, required String text, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(text, style: TextStyle(color: Colors.blue)),
      onTap: onTap,
    );
  }
}
