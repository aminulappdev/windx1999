import 'package:flutter/material.dart';
import 'package:windx1999/app/res/common_widgets/custom_rectangle_buttom.dart';

class CustomDeleteDialog extends StatelessWidget {
  final VoidCallback yesOntap;
  final VoidCallback noOntap;
  final IconData iconData;
  final String title;
  final String subtitle;

  const CustomDeleteDialog({
    super.key,
    required this.iconData,
    required this.title,
    required this.yesOntap,
    required this.noOntap,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffA062FA), Color(0xffA386F0)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              iconData,
              color: Colors.white,
              size: 40,
            ),
            SizedBox(height: 16),
            title == ''
                ? Container()
                : Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
            title == '' ? SizedBox(height: 0) : SizedBox(height: 16),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomRectangleButton(
                  bgColor: Colors.white,
                  height: 40,
                  width: 120,
                  radiusSize: 12,
                  text: 'No',
                  ontap: noOntap,
                  borderColor: Colors.blue,
                  textColor: Colors.blue,
                ),
                SizedBox(width: 16),
                CustomRectangleButton(
                  bgColor: Colors.blue,
                  height: 40,
                  width: 120,
                  radiusSize: 12,
                  text: 'Yes',
                  ontap: yesOntap,
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
