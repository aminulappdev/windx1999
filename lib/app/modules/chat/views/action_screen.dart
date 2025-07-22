import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:windx1999/app/modules/chat/controllers/delete_chatData_controller.dart';
import 'package:windx1999/app/modules/chat/views/chat_list_screen.dart';
import 'package:windx1999/app/modules/homepage/widgets/bottonSheet_details_row.dart';
import 'package:windx1999/app/modules/profile/views/own_profile/block_user.dart';
import 'package:windx1999/app/modules/profile/views/own_profile/report_screen.dart';
import 'package:windx1999/app/res/common_widgets/custom_app_bar.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/common_widgets/custom_snackbar.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class ActionScreen extends StatefulWidget {
  final String authorId;
  final String authorName;
  final String authorImage;
  final String chatId;
  const ActionScreen(
      {super.key,
      required this.authorId,
      required this.authorName,
      required this.authorImage,
      required this.chatId});

  @override
  State<ActionScreen> createState() => _ActionScreenState();
}

class _ActionScreenState extends State<ActionScreen> {
  final DeleteChatdataController deleteChatdataController =
      Get.put(DeleteChatdataController());
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
              CustomAppBar(title: 'Aminul'),
              heightBox14,
              ButtonSheetDetailsRow(
                icon: Icons.delete,
                name: 'Delete',
                ontap: deleteChat,
              ),
              heightBox20,
              ButtonSheetDetailsRow(
                icon: Icons.sms,
                name: 'Report profile',
                ontap: () {
                  Get.to(ReportScreen(
                      reportType: 'User', reportId: widget.authorId));
                },
              ),
              heightBox20,
              ButtonSheetDetailsRow(
                icon: Icons.person_off,
                name: 'Block',
                ontap: () {
                  Get.to(BlockUserScreen(
                      userId: widget.authorId,
                      userName: widget.authorName,
                      userImage: widget.authorImage));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> deleteChat() async {
    final bool isSuccess =
        await deleteChatdataController.deleteChataData(chatId: widget.chatId);
    if (isSuccess) {
      Get.to(ChatListScreen());
      if (mounted) {
        // showSnackBarMessage(context, 'Post hidden successfully');
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, deleteChatdataController.errorMessage ?? 'Failed', true);
      }
    }
  }
}
