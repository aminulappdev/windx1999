import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:windx1999/app/modules/common/controllers/all_blockers_controller.dart';
import 'package:windx1999/app/modules/common/controllers/unblock_controller.dart';
import 'package:windx1999/app/res/common_widgets/custom_app_bar.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/common_widgets/custom_rectangle_buttom.dart';
import 'package:windx1999/app/res/common_widgets/custom_snackbar.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class BlockScreen extends StatefulWidget {
  const BlockScreen({super.key});

  @override
  State<BlockScreen> createState() => _BlockScreenState();
}

class _BlockScreenState extends State<BlockScreen> {
  final AllBlockersController allBlockersController =
      Get.put(AllBlockersController());
  final UnblockController unblockController = Get.put(UnblockController());

  @override
  void initState() {
    allBlockersController.getAllBlockers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        child: Padding(
          padding: EdgeInsets.all(16.0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heightBox20,
              CustomAppBar(title: 'Block Account'),
              heightBox12,
              GetBuilder<AllBlockersController>(builder: (controller) {
                
                if (allBlockersController.inProgress) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Expanded(
                    child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: controller.allBlockersData?.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(8.0.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 20.h,
                                backgroundImage: NetworkImage(controller
                                        .allBlockersData![index]
                                        .blocked
                                        ?.photoUrl ??
                                    ''),
                              ),
                              widthBox8,
                              Text(
                                controller.allBlockersData![index].blocked
                                        ?.name ??
                                    '',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.h,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          CustomRectangleButton(
                            bgColor: Colors.lightBlue,
                            height: 32,
                            width: 90,
                            radiusSize: 8,
                            text: 'Unblock',
                            ontap: () {
                              userUnblock(
                                  controller.allBlockersData![index].blocked!.id!);
                            },
                            textSize: 12,
                            borderColor: Colors.lightBlue,
                            textColor: Colors.white,
                          )
                        ],
                      ),
                    );
                  },
                ));
              })
            ],
          ),
        ),
      ),
    );
  }

  Future<void> userUnblock(String userId) async {
    final bool isSuccess = await unblockController.userUnblock(userId);

    if (isSuccess) {
      allBlockersController.getAllBlockers();
      showSnackBarMessage(context, 'Successfully unblocked');
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
