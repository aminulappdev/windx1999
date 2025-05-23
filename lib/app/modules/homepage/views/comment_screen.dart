import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:windx1999/app/modules/common/controllers/theme_controller.dart';
import 'package:windx1999/app/modules/homepage/widgets/coment_section.dart';
import 'package:windx1999/app/res/app_images/assets_path.dart';
import 'package:windx1999/app/res/common_widgets/custom_app_bar.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({super.key});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  ThemeController themeController = Get.find<ThemeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: EdgeInsets.all(0.0),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(20.0.h),
                  child: Column(
                    children: [
                      heightBox20,
                      CustomAppBar(title: 'Comments'),
                      heightBox40,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage(AssetsPath.blackGirl),
                          ),
                          widthBox8,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Aminul',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18.sp),
                              ),
                              Text(
                                'Massalah sundor hoiche',
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                'Reply..',
                                style: TextStyle(color: Colors.white),
                              ),
                              heightBox14,
                              CommentSection(
                                imagePath: AssetsPath.blackGirl,
                                name: 'Aminul',
                                comment: 'Massalah sundor hoiche',
                                replyOntap: () {},
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SizedBox.shrink(),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: GetBuilder<ThemeController>(builder: (controller) {
                    return Container(
                      decoration: BoxDecoration(
                        color: controller.isDarkMode == true
                            ? Color(0xff333333)
                            : Color(0xffFFFFFF).withOpacity(0.32),
                      ),
                      height: 82.h,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: EdgeInsets.all(8.0.h),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 18.r,
                              backgroundImage: AssetImage(AssetsPath.blackGirl),
                            ),
                            SizedBox(
                              width: 300.w,
                              child: TextFormField(
                                style: TextStyle(
                                    color: controller.isDarkMode == true
                                        ? Colors.white
                                        : Colors.black),
                                decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                        color: controller.isDarkMode == true
                                            ? Colors.white
                                            : Colors.black),
                                    fillColor: Colors.transparent,
                                    hintText: 'Writes a comment',
                                    suffixIcon: Icon(
                                      Icons.attach_file,
                                      color: controller.isDarkMode == true
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    contentPadding: EdgeInsets.all(10.h)),
                              ),
                            ),
                            Icon(
                              Icons.send,
                              color: controller.isDarkMode == true
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
