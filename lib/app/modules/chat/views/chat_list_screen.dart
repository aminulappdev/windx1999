import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:windx1999/app/modules/chat/controllers/all_friend_controller.dart';
import 'package:windx1999/app/modules/chat/views/chat_screen.dart';
import 'package:windx1999/app/modules/common/controllers/theme_controller.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/common_widgets/search_bar.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';
import 'package:windx1999/app/services/socket/socket_service.dart';
import 'package:windx1999/get_storage.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final SocketService socketService = Get.put(SocketService());
  final FriendController friendController = Get.put(FriendController());
  final ThemeController themeController = Get.find<ThemeController>();
  final TextEditingController searchCtrl = TextEditingController();
  String search = '';

  @override
  void initState() {
    super.initState();
    socketService.init();
    friendController.getAllFriends();

    searchCtrl.addListener(() {
      setState(() {
        search = searchCtrl.text;
      });
    });

    socketService.sokect.on(
      'chat-list::${StorageUtil.getData(StorageUtil.userId)}',
      (data) {
        print('Socket chatlist data received ...............');
        print('Raw data: $data');
        _handleIncomingFriends(data);
      },
    );
  }

  @override
  void dispose() {
    searchCtrl.dispose();
    super.dispose();
  }

  void _handleIncomingFriends(dynamic data) {
    if (data == null) return;

    if (data is List) {
      socketService.socketFriendtList.clear();
      for (var friend in data) {
        if (friend is Map<String, dynamic> && friend['chat'] != null) {
          final chat = friend['chat'];
          final message = friend['message'];
          final participants = chat['participants'] as List? ?? [];
          final participant = participants.isNotEmpty ? participants[0] : null;

          socketService.socketFriendtList.add({
            "id": chat['_id']?.toString() ?? '',
            "receiverId": participant?['_id']?.toString() ?? '',
            "name": participant?['name'] ?? 'No Name',
            "email": participant?['email'] ?? '',
            "profileImage": participant?['photoUrl'] ?? '',
            "createdAt":
                chat['createdAt'] ?? DateTime.now().toIso8601String(),
            "lastMessage":
                message != null ? message['text'] ?? 'No Message' : 'No Message',
            "lastMessageTime": message != null
                ? message['createdAt'] ?? DateTime.now().toIso8601String()
                : DateTime.now().toIso8601String(),
            "isSeen": message != null ? message['seen'] ?? false : false,
            "unreadMessageCount": friend['unreadMessageCount'] ?? 0,
          });
        }
      }
      socketService.socketFriendtList.refresh();
    } else if (data is Map<String, dynamic>) {
      final chat = data['chat'];
      final message = data['message'];
      final participants = chat?['participants'] as List? ?? [];
      final participant = participants.isNotEmpty ? participants[0] : null;

      final newFriend = {
        "id": chat?['_id']?.toString() ?? '',
        "receiverId": participant?['_id']?.toString() ?? '',
        "name": participant?['name'] ?? 'No Name',
        "email": participant?['email'] ?? '',
        "profileImage": participant?['photoUrl'] ?? '',
        "createdAt":
            chat?['createdAt'] ?? DateTime.now().toIso8601String(),
        "lastMessage":
            message != null ? message['text'] ?? 'No Message' : 'No Message',
        "lastMessageTime": message != null
            ? message['createdAt'] ?? DateTime.now().toIso8601String()
            : DateTime.now().toIso8601String(),
        "isSeen": message != null ? message['seen'] ?? false : false,
        "unreadMessageCount": data['unreadMessageCount'] ?? 0,
      };

      final existingIndex = socketService.socketFriendtList.indexWhere(
        (f) => f['id'] == newFriend['id'],
      );

      if (existingIndex != -1) {
        socketService.socketFriendtList[existingIndex] = newFriend;
      } else {
        socketService.socketFriendtList.add(newFriend);
      }
      socketService.socketFriendtList.refresh();
    }
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
              Text(
                'Chat List',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              heightBox12,
              GetBuilder<ThemeController>(builder: (controller) {
                return TextFormField(
                  controller: searchCtrl,
                  style: TextStyle(
                    color: controller.isDarkMode == true
                        ? Colors.white
                        : Colors.black,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: controller.isDarkMode == true
                          ? Colors.white
                          : Colors.black,
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 8.h),
                    hintText: 'Search',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: controller.isDarkMode == true
                          ? Colors.white
                          : Colors.black,
                    ),
                    fillColor: const Color.fromARGB(116, 255, 255, 255),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide.none,
                    ),
                  ),
                );
              }),
              heightBox14,
              Text(
                'Message',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              heightBox8,
              Expanded(
                child: Obx(() {
                  final friendList = socketService.socketFriendtList;

                  if (friendController.inProgress.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final filteredFriends = friendList.where((friend) {
                    final name = friend['name']?.toLowerCase() ?? '';
                    return search.isEmpty ||
                        name.contains(search.toLowerCase());
                  }).toList();

                  if (filteredFriends.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'No results for "${search.isEmpty ? 'Friends' : search}"',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          heightBox4,
                          Text(
                            'We couldn’t find any matching chats. Please refine your search or check back later.',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.white70,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: filteredFriends.length,
                    itemBuilder: (context, index) {
                      final friend = filteredFriends[index];
                      final String chatId = friend['id'] ?? '';
                      final String receiverId = friend['receiverId'] ?? '';
                      final String receiverName = friend['name'] ?? 'No Name';
                      final String receiverImage = friend['profileImage'] ?? '';
                      final String lastMessage =
                          friend['lastMessage'] ?? 'No Message';

                      String formattedTime = '';
                      try {
                        final timestamp = DateTime.parse(friend['createdAt'] ??
                            DateTime.now().toIso8601String());
                        formattedTime =
                            DateFormat('MMM d, HH:mm').format(timestamp);
                      } catch (e) {
                        formattedTime =
                            DateFormat('MMM d, HH:mm').format(DateTime.now());
                      }

                      return InkWell(
                        onTap: () {
                          Get.to(() => ChatScreen(
                                chatId: chatId,
                                receiverId: receiverId,
                                receiverName: receiverName,
                                receiverImage: receiverImage,
                              ));
                        },
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(
                            radius: 24.r,
                            backgroundImage: receiverImage.isNotEmpty
                                ? NetworkImage(receiverImage)
                                : const AssetImage(
                                        'assets/images/default_user.png')
                                    as ImageProvider,
                          ),
                          title: Text(
                            receiverName,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          subtitle: Text(
                            lastMessage,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
