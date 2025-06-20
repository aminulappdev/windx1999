import 'package:flutter/material.dart';


class GradientElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool isRowButton;
  const GradientElevatedButton(
      {super.key,
      required this.onPressed,
      required this.text,
      required this.isRowButton});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
       
        borderRadius: BorderRadius.circular(20),
      ),
      child: isRowButton
          ? elevatedwithRow(height, width)
          : elevatedButton(height, width),
    );
  }

  ElevatedButton elevatedwithRow(double height, double width) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: const Size.fromWidth(double.maxFinite),
        backgroundColor: Colors.transparent, // Make background transparent
        shadowColor: Colors.transparent, // Remove default shadow
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: height / 50),
          ),
          SizedBox(
            width: 255,
          ),
          Icon(
            Icons.arrow_forward_sharp,
            color: Colors.white,
            size: 18,
          )
        ],
      ),
    );
  }

  ElevatedButton elevatedButton(double height, double width) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: const Size.fromWidth(double.maxFinite),
        backgroundColor: Colors.transparent, // Make background transparent
        shadowColor: Colors.transparent, // Remove default shadow
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: height / 50),
      ),
    );
  }
}
