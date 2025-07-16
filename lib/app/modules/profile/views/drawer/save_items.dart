import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:windx1999/app/modules/common/controllers/save_my_post_controller.dart';
import 'package:windx1999/app/modules/homepage/controller/delete_save_post_controller.dart';
import 'package:windx1999/app/res/app_images/assets_path.dart';
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
              heightBox20,
              CustomAppBar(title: 'Save item'),
              heightBox16,
              GetBuilder<SaveAllPostController>(builder: (controller) {
                if (controller.inProgress) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: controller.savePostData?.length ?? 0,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                controller.savePostData![index].content!.content
                                        .isEmpty
                                    ? const SizedBox()
                                    : ImageContainer(
                                        imagePath: controller
                                                .savePostData![index]
                                                .content
                                                ?.content[0] ??
                                            '',
                                        height: 62,
                                        width: 60,
                                        borderRadius: 8,
                                        borderColor: Colors.transparent),
                                widthBox8,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: controller.savePostData![index]
                                              .content!.content.isEmpty
                                          ? 300.w
                                          : 235.w,
                                      child: Text(
                                        controller.savePostData![index].content
                                                ?.description ??
                                            '',
                                        style: TextStyle(
                                            fontSize: 16.sp,
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
