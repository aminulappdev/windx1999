import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:windx1999/app/modules/common/controllers/theme_controller.dart';
import 'package:windx1999/app/modules/post/controller/comment_controller.dart';
import 'package:windx1999/app/res/app_images/assets_path.dart';
import 'package:windx1999/app/res/common_widgets/custom_app_bar.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class CommentScreen extends StatefulWidget {
  final String postId;
  const CommentScreen({super.key, required this.postId});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  ThemeController themeController = Get.find<ThemeController>();
  final CommentController commentController = Get.put(CommentController());

  @override
  void initState() {
    commentController.getAllComment(widget.postId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.h),
            child: Column(
              children: [
                heightBox20,
                const CustomAppBar(title: 'Comments'),
                heightBox40,
                GetBuilder<CommentController>(builder: (controller) {
                  if (controller.commentData == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (controller.commentData!.isEmpty) {
                    return const Center(
                      child: Text(
                        'No comments yet.',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }

                  return Expanded(
                    child: ListView.builder(
                      itemCount: controller.commentData!.length,
                      itemBuilder: (context, index) {
                        final comment = controller.commentData![index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 16.0.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 24.r,
                                backgroundImage: comment.user?.photoUrl != null
                                    ? NetworkImage(comment.user!.photoUrl!)
                                    : AssetImage(AssetsPath.blackGirl)
                                        as ImageProvider,
                                backgroundColor: Colors.grey[800],
                              ),
                              widthBox8,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      comment.user?.name ?? '',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18.sp),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      comment.comment ?? '',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16.sp),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      'Reply..',
                                      style: TextStyle(
                                          color: Colors.white70, fontSize: 14.sp),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
