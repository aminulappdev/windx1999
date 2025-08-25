import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windx1999/app/res/common_widgets/custom_rectangle_buttom.dart';

class CustomRefundDialog extends StatefulWidget {
  final VoidCallback yesOntap;
  final VoidCallback noOntap;
  final IconData iconData;
  final String title;

  const CustomRefundDialog({
    super.key,
    required this.iconData,
    required this.title,
    required this.yesOntap,
    required this.noOntap,
  });

  @override
  State<CustomRefundDialog> createState() => _CustomRefundDialogState();
} 

class _CustomRefundDialogState extends State<CustomRefundDialog> {
  final TextEditingController reasonCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(20.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffA062FA), Color(0xffA386F0)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10.h),
            widget.title == ''
                ? Container()
                : Text(
                    widget.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
            widget.title == '' ? SizedBox(height: 0) : SizedBox(height: 16.h),
            TextFormField(
              maxLength: 30,
              maxLines: 3,
              controller: reasonCtrl,
              decoration: InputDecoration(
                hintText: 'Enter your name',
                errorStyle:
                    TextStyle(color: const Color.fromARGB(255, 237, 82, 82)),
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomRectangleButton(
                  bgColor: Colors.white,
                  height: 40,
                  width: 120,
                  radiusSize: 12,
                  text: 'No',
                  ontap: widget.noOntap,
                  borderColor: Colors.blue,
                  textColor: Colors.blue,
                ),
                SizedBox(width: 16),
                CustomRectangleButton(
                  bgColor: Colors.blue,
                  height: 40,
                  width: 120,
                  radiusSize: 12,
                  text: 'Send',
                  ontap: widget.yesOntap,
                  borderColor: Colors.blue,
                  textColor: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
