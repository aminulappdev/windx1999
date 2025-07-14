import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:windx1999/app/modules/chat/controllers/all_friend_controller.dart';
import 'package:windx1999/app/modules/chat/views/chat_screen.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/common_widgets/search_bar.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';
import 'package:windx1999/app/services/socket/socket_service.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final SocketService socketService = Get.put(SocketService());
  final FriendController friendController = Get.put(FriendController());

  @override
  void initState() {
    super.initState();
    socketService.init();
    friendController.getAllFriends();
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
              InkWell(
                onTap: () {},
                child: Text(
                  'Aminul Islam',
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
              heightBox12,
              CustomSearchBar(),
              heightBox14,
              Text(
                'Message',
                style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              heightBox8,
              Expanded(
                child: GetBuilder<FriendController>(builder: (controller) {
                  if (controller.inProgress) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (controller.friendList.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Your Chats with Friends Will Appear Here.',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          heightBox4,
                          Text(
                            'No Friends Found at this time',
                            style:
                                TextStyle(fontSize: 12, color: Colors.white70),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: controller.friendList.length,
                    itemBuilder: (context, index) {
                      final friend = controller.friendList[index];
                      final participant = friend.chat?.participants[0];

                      return InkWell(
                        onTap: () {
                          Get.to(() => ChatScreen(
                                chatId: friend.chat?.id ?? '',
                                receiverId: participant?.id ?? '',
                                receiverName: participant?.name ?? '',
                                receiverImage: participant?.photoUrl ?? '',
                                // chatId: friend.chat?.id ?? '',
                                // receiverId: participant?.id ?? '',
                                // receiverName: participant?.name ?? '',
                                // receiverImage: participant?.photoUrl ?? '',
                              ));
                        },
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(
                            radius: 24.r,
                            backgroundImage: participant?.photoUrl != null
                                ? NetworkImage(participant!.photoUrl!)
                                : const AssetImage(
                                        'assets/images/default_user.png')
                                    as ImageProvider,
                          ),
                          title: Text(
                            participant?.name ?? 'No Name',
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                          subtitle: Text(
                            friend.message?.text ?? 'No Message',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.white70),
                          ),
                          trailing: friend.unreadMessageCount != null &&
                                  friend.unreadMessageCount! > 0
                              ? CircleAvatar(
                                  radius: 10,
                                  backgroundColor: const Color(0xff6CC7FE),
                                  child: Text(
                                    friend.unreadMessageCount.toString(),
                                    style: const TextStyle(
                                        fontSize: 10, color: Colors.white),
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ),
                      );
                    },
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
