import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:windx1999/app/modules/common/controllers/save_my_post_controller.dart';
import 'package:windx1999/app/modules/homepage/controller/delete_save_post_controller.dart';
import 'package:windx1999/app/modules/homepage/widgets/image_container.dart';
import 'package:windx1999/app/modules/post/views/post_details_page.dart';
import 'package:windx1999/app/res/common_widgets/custom_app_bar.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/common_widgets/custom_dialoge.dart';
import 'package:windx1999/app/res/common_widgets/custom_snackbar.dart';
import 'package:windx1999/app/res/common_widgets/image_container.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class SaveItemScreen extends StatefulWidget {
  const SaveItemScreen({super.key});

  @override
  State<SaveItemScreen> createState() => _SaveItemScreenState();
}

class _SaveItemScreenState extends State<SaveItemScreen> {
  final SaveAllPostController saveAllPostController =
      Get.put(SaveAllPostController());
  final DeleteSavePostController deleteSavePostController =
      Get.put(DeleteSavePostController());

  @override
  void initState() {
    saveAllPostController.getMySavePost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        child: Padding(
          padding: EdgeInsets.all(8.0.h),
          child: Column(
            children: [
              heightBox30,
              CustomAppBar(title: 'Save item'),
              heightBox16,
              GetBuilder<SaveAllPostController>(builder: (controller) {
                if (controller.inProgress) {
                  return SizedBox(
                      height: 630,
                      child: const Center(child: CircularProgressIndicator()));
                }
                if (controller.savePostData!.isEmpty) {
                  return SizedBox(
                      height: 630,
                      width: double.infinity,
                      child: Center(
                          child: Text(
                        'No save data available',
                        style: TextStyle(color: Colors.white),
                      )));
                }
                return Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: controller.savePostData?.length ?? 0,
                    itemBuilder: (context, index) {
                      // Safely check if content and content list exist and are not empty
                      final content = controller.savePostData![index].content;
                      final hasValidContent =
                          content != null && content.content.isNotEmpty;

                      // Only set mediaPath if content is valid; otherwise, no media is shown
                      final mediaPath = hasValidContent
                          ? content.content[0]
                          : null; // No fallback URL when content is empty
                      final isVideo = hasValidContent &&
                          mediaPath!.toLowerCase().contains('/videos/');

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.to(PostDetailsPage(
                                  contentType: controller
                                      .savePostData![index].modelType
                                      .toString(),
                                  contentId: controller
                                          .savePostData![index].content?.id ??
                                      '',
                                ));
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Only show media if content is valid
                                  hasValidContent
                                      ? isVideo
                                          ? MediaContainer(
                                              mediaPath: mediaPath,
                                              height: 62,
                                              width: 50,
                                              borderRadius: 8,
                                              borderColor: Colors.transparent,
                                            )
                                          : ImageContainer(
                                              imagePath: mediaPath!,
                                              height: 62,
                                              width: 50,
                                              borderRadius: 8,
                                              borderColor: Colors.transparent,
                                            )
                                      : const SizedBox(), // Placeholder space
                                  widthBox5,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: hasValidContent ? 235.w : 300.w,
                                        child: Text(
                                          controller.savePostData![index]
                                                  .content?.description ??
                                              'No description available',
                                          style: TextStyle(
                                              fontSize: 14.sp,
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
                                            controller
                                                .savePostData![index].modelType
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CustomDeleteDialog(
                                      noOntap: () {
                                        Navigator.pop(context);
                                      },
                                      yesOntap: () {
                                        deleteSavePost(controller
                                            .savePostData![index].id
                                            .toString());
                                        Navigator.pop(context);
                                      },
                                      iconData: Icons.delete,
                                      subtitle:
                                          'Do you want to Delete save item?',
                                      title: '',
                                    );
                                  },
                                );
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
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> deleteSavePost(String postId) async {
    final bool isSuccess =
        await deleteSavePostController.deleteSavePost(postId: postId);

    if (isSuccess) {
      saveAllPostController.getMySavePost();
      showSnackBarMessage(context, 'Delete successfully done');
    } else {
      Get.snackbar(
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.TOP,
        'Failed',
        'Failed to delete account',
      );
    }
  }
}
