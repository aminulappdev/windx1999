
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windx1999/app/res/common_widgets/image_container.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class TokenBarHeader extends StatelessWidget {
  final String imagePath;
  final String token;
  const TokenBarHeader({
    super.key, required this.imagePath, required this.token,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ImageContainer(
            imagePath: imagePath,
            height: 80,
            width: 80,
            borderRadius: 100,
            borderColor: Colors.transparent),
        widthBox12,
        Container(
          height: 80.h,
          width: 250.w,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              color: Color(0xffFFFFFF).withOpacity(0.50),
              borderRadius: BorderRadius.circular(12)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Your token',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.token_rounded,
                    size: 36,
                  ),
                  widthBox8,
                  Text(
                    token,
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}