
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChattingFieldWidget extends StatefulWidget {
  // Added controller and validator parameters
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const ChattingFieldWidget({
    super.key,
    this.controller, // Added to support TextEditingController
    this.validator, // Added to support form validation
  });

  @override
  State<ChattingFieldWidget> createState() => _ChattingFieldWidgetState();
}

class _ChattingFieldWidgetState extends State<ChattingFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: TextFormField( // Changed TextField to TextFormField for validation
        controller: widget.controller, // Added controller
        validator: widget.validator, // Added validator
        decoration: InputDecoration(
          hintText: 'Write message',
          hintStyle: TextStyle(color: Colors.grey.shade600),
          // prefixIcon: InkWell(
          //   onTap: () {
          //     _showPopupMenu(context); // Show the popup menu when clicked
          //   },
          //   child: Icon(Icons.dashboard, color: Colors.grey.shade600),
          // ),
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

  void _showPopupMenu(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: const Color.fromARGB(255, 242, 234, 247),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(12.0.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildOption(context, Icons.photo, "Gallery"),
                    _buildOption(context, Icons.description, "Document"),
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildOption(context, Icons.contact_page, "Contact"),
                    _buildOption(context, Icons.location_on, "Location"),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildOption(BuildContext context, IconData icon, String text) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            height: 53,
            width: 53,
            decoration: BoxDecoration(
              border: Border.all(color: const Color.fromARGB(216, 158, 158, 158)),
              color: const Color.fromARGB(185, 255, 255, 255),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: const Color(0xFF7B3DD3), size: 30.sp),
          ),
        ),
        SizedBox(height: 5.h),
        Text(text, style: TextStyle(color: Colors.black)),
      ],
    );
  }
}

