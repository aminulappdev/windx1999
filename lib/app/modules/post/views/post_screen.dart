import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:windx1999/app/modules/post/views/post_audiences.dart';
import 'package:windx1999/app/res/app_images/assets_path.dart';
import 'package:windx1999/app/res/common_widgets/custom_app_bar.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';
import 'package:dotted_border/dotted_border.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomBackground(
          child: Padding(
            padding:  EdgeInsets.all(16.0.h),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   heightBox20,
                  CustomAppBar(
                    title: 'New post',
                    showButton: true,
                    ontap: () {},
                    color: Colors.white,
                    textColor: Colors.grey,
                  ),
                  heightBox20,
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(AssetsPath.blackGirl),
                      ),
                      widthBox5,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nammi Fatema',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                          heightBox4,
                          InkWell(
                            onTap: () {
                              Get.to(PostAudiencesScreen());
                            },
                            child: Container(
                              height: 24.h,
                              width: 80.w,
                              decoration: BoxDecoration(
                                color: const Color(0xffEBF5FF),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.group, size: 14),
                                  widthBox4,
                                  Text(
                                    'Friends',
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  heightBox20,
                  TextFormField(
                    maxLines: 4,
                    decoration: InputDecoration(
                        fillColor: const Color.fromARGB(166, 255, 255, 255),
                        hintText: 'Type your status here..',
                        hintStyle: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                  heightBox12,
                  heightBox14,
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      radius: Radius.circular(8),
                      padding: EdgeInsets.all(12),
                      color: Colors.white,
                      strokeWidth: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        child: SizedBox(
                          height: 160,
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                    onTap: () {},
                                    child: Icon(
                                      Icons.upload,
                                      size: 50,
                                      color: Colors.white,
                                    )),
                                Text(
                                  'Drop your imager here, or browse jpg, png are allowed',
                                  style:
                                      TextStyle(fontSize: 10, color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  heightBox12,
                  
                ],
              ),
            ),
          ),
        ),
      
    );
  }
}
