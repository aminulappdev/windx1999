
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class CommentSection extends StatelessWidget {
  final String name;
  final String comment;
  final VoidCallback replyOntap;
  final String imagePath;
  const CommentSection({
    super.key,
    required this.name,
    required this.comment,
    required this.replyOntap,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(imagePath),
        ),
        widthBox8,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(color: Colors.white, fontSize: 18.sp),
            ),
            Text(
              comment,
              style: TextStyle(color: Colors.white),
            ),
            InkWell(
              onTap: replyOntap,
              child: Text(
                'Reply..',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        )
      ],
    );
  }
}
