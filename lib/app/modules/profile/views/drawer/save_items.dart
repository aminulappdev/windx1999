import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windx1999/app/res/app_images/assets_path.dart';
import 'package:windx1999/app/res/common_widgets/custom_app_bar.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/common_widgets/custom_dialoge.dart';
import 'package:windx1999/app/res/common_widgets/image_container.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class SaveItemScreen extends StatelessWidget {
  const SaveItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomBackground(
          child: Padding(
            padding:  EdgeInsets.all(8.0.h),
            child: Column(
              children: [
               heightBox20,
                  CustomAppBar(title: 'Save item'),
                heightBox16,
                Expanded(
                  child: ListView.builder(
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ImageContainer(
                                    imagePath: AssetsPath.blackGirl,
                                    height: 62,
                                    width: 60,
                                    borderRadius: 8,
                                    borderColor: Colors.transparent),
                                widthBox8,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'I Phone 14 pro max',
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                    heightBox4,
                                    SizedBox(
                                      width: 220.w,
                                      child: Text(
                                        '"Capturing moments that speak."',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white),
                                      ),
                                    ),
                                    heightBox4,
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 3.h,
                                          backgroundColor: Colors.blue,
                                        ),
                                        widthBox8,
                                        Text(
                                          'Wishlist',
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () {
                                _showDeleteDialog(context);
                              },
                              icon: Icon(
                                Icons.more_vert,
                                color: Colors.white,
                                size: 30.h,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDeleteDialog(
          noOntap: () {
            
            Navigator.pop(context); 
          },
          yesOntap: () {
            Navigator.pop(context); 
          }, iconData: Icons.delete,
          subtitle: 'Do you want to Delete save item?', title: '',
        );
      },
    );
  }
}
