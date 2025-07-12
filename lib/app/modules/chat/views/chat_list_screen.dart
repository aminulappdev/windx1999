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
    socketService.init();
    friendController.getAllFriends();
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
              GetBuilder<FriendController>(builder: (controller) {
                if (controller.inProgress) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.friendList.isEmpty) {
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Your Chats with a Friends Will Appear Here.',
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                      heightBox4,
                      Text(
                        'No Friends Found at this time',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ));
                }
                return Expanded(
                    child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: controller.friendList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.to(ChatScreen(
                            // chatId: '',
                            // receiverId: '',
                            // receiverName: '',
                            // receiverImage: '',
                            ));
                      },
                      child: ListTile(
                        contentPadding: EdgeInsets.all(0),
                        leading: CircleAvatar(
                          radius: 24.r,
                          backgroundImage: NetworkImage(controller
                                  .friendList[index]
                                  .chat
                                  ?.participants[0]
                                  .photoUrl ??
                              'https://fastly.picsum.photos/id/1/200/300.jpg?hmac=jH5bDkLr6Tgy3oAg5khKCHeunZMHq0ehBZr6vGifPLY'),
                        ),
                        title: Text(
                          controller.friendList[index].chat?.participants[0]
                                  .name ??
                              'No Name',
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                        subtitle: Text(
                          controller.friendList[index].message ?? 'No Message',
                          style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                        ),
                        trailing: CircleAvatar(
                          radius: 5,
                          backgroundColor: Color(0xff6CC7FE),
                        ),
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
}
