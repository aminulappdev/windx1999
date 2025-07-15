import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:windx1999/app/modules/chat/controllers/message_controller.dart';
import 'package:windx1999/app/modules/chat/controllers/message_send_controller.dart';
import 'package:windx1999/app/modules/chat/views/action_screen.dart';
import 'package:windx1999/app/modules/chat/widgets/chat_appBar.dart';
import 'package:windx1999/app/modules/chat/widgets/chat_field.dart';
import 'package:windx1999/app/res/app_images/assets_path.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/common_widgets/liner_widget.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';
import 'package:intl/intl.dart';

// Added imports for socket and message handling
import 'package:windx1999/app/modules/profile/controllers/profile_controller.dart'; // Assuming similar profile controller
import 'package:windx1999/app/services/socket/socket_service.dart';
import 'package:windx1999/get_storage.dart'; // Assuming socket service

class ChatScreen extends StatefulWidget {
  // Added required parameters for chat functionality
  final String chatId;
  final String receiverId;
  final String receiverName;
  final String receiverImage;

  const ChatScreen({
    super.key,
    required this.chatId,
    required this.receiverId,
    required this.receiverName,
    required this.receiverImage,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<CameraDescription>? cameras;
  // Removed static messageList and replaced with socket service
  // final List<Map<String, dynamic>> messageList = [...];

  // Added controllers and services
  final ProfileController profileController = Get.find<ProfileController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final SocketService socketService = Get.put(SocketService());
  final TextEditingController messageController = TextEditingController();
  final MessageController messageFetchController = Get.put(MessageController());
  final MessageSendController messageSendController =
      Get.put(MessageSendController());
  final ScrollController _scrollController = ScrollController();
  bool isLoading = false;
  bool isSending = false;
  bool isTextEmpty = true;
  String updatesenderId = '';
  String updatereceiverId = '';
  late String senderId;

  @override
  void initState() {
    super.initState();
    // Initialize senderId and socket connection
    senderId = profileController.profileData?.id ?? '';
    print('Sender ID: $senderId');

    socketService.init(); // Initialize the socket connection
    updatesenderId = senderId; // Initialize with actual senderId
    updatereceiverId = widget.receiverId;

    // Listen for incoming messages from the socket
    socketService.sokect.on('new-message::${widget.chatId}', (data) {
      print('Socket data received ...............');
      updatesenderId = data['sender'];
      updatereceiverId = data['receiver'];
      print('senderId: ${data['sender']}');
      print('receiverId: ${data['receiver']}');
      _handleIncomingMessage(data);
    });

    socketService.sokect
        .on('chat-list::${StorageUtil.getData(StorageUtil.userId)}', (data) {
      print('Socket chatlist data received ...............');
      print(data);
      _handleIncomingFriends(data);
    });

    // Fetch initial messages from the server
    messageFetchController.getMessages(chatId: widget.chatId).then((_) {
      // Check if messageList is empty and auto-message hasn't been sent
      if (messageFetchController.messageList.isEmpty) {
        messageFetchController.sendAutoTherapistMessage(
          chatId: widget.chatId,
          receiverId: widget.receiverId,
          therapistName: widget.receiverName,
        );
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToEnd();
      });
    });

    // Track text field content
    messageController.addListener(() {
      setState(() {
        isTextEmpty = messageController.text.trim().isEmpty;
      });
    });
  }

  @override
  void dispose() {
    // Clean up controllers and socket listeners
    messageController.dispose();
    _scrollController.dispose();
    socketService.sokect.off('new-message::${widget.chatId}');
    super.dispose();
  }

  // Added method to scroll to the end of the chat
  void _scrollToEnd() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  // Added method to handle incoming socket messages
  void _handleIncomingMessage(dynamic data) {
    if (data['createdAt'] == null) {
      data['createdAt'] = DateTime.now().toIso8601String();
    }
    socketService.messageList.add(data);
    _scrollToEnd();
  }

  void _handleIncomingFriends(dynamic data) {  
    
  }

  // Added method to send messages
  Future<void> sendMessageBTN(
      String chatId, String text, String receiverId) async {
    if (_formKey.currentState!.validate() &&
        !isSending &&
        text.trim().isNotEmpty) {
      setState(() {
        isSending = true;
      });

      socketService.sokect.emit('send-message', {
        'text': text,
        'sender': senderId,
        'receiver': receiverId,
      });

      socketService.sokect
          .on('chat-list::${StorageUtil.getData(StorageUtil.userId)}', (data) {
        print(
            'Chat list data er socket data ...................................................f\n$data');
      });

      socketService.sokect.on('new-message::${widget.chatId}', (data) {
        print(data);
      });

      final bool isSuccess =
          await messageSendController.sendMessage(chatId, text, receiverId);

      // if (isSuccess) {
      //   if (mounted) {
      //     messageController.clear();
      //     WidgetsBinding.instance.addPostFrameCallback((_) {
      //       _scrollToEnd();
      //     });
      //     Get.snackbar('Message Sent', 'Your message was successfully sent');
      //   }
      // } else {
      //   if (mounted) {
      //     Get.snackbar(
      //       'Error',
      //       messageSendController.errorMessage ?? 'Failed to send message',
      //     );
      //   }
      // }

      if (mounted) {
        setState(() {
          isSending = false;
        });
      }
    } else if (text.trim().isEmpty) {
      Get.snackbar('Error', 'Message cannot be empty');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        child: Padding(
          padding: EdgeInsets.all(12.0.h),
          child: Column(
            children: [
              heightBox20,
              // Updated CustomChatAppBar to use dynamic receiver details
              CustomChatAppBar(
                name: widget.receiverName,
                imagePath: widget.receiverImage.isNotEmpty
                    ? widget.receiverImage
                    : AssetsPath.blackGirl,
                activeStatus: 'Active',
                isActive: true,
                actionOntap: () {
                  Get.to(ActionScreen());
                },
              ),
              Liner(text: 'Today'),
              // Replaced static messageList with socketService.messageList
              Expanded(
                child: Obx(() {
                  if (messageFetchController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (socketService.messageList.isEmpty) {
                    return const Center(child: Text('No Messages Found'));
                  }

                  return ListView.builder(
                    controller: _scrollController, // Added ScrollController
                    padding: EdgeInsets.all(10.r),
                    itemCount: socketService.messageList.length,
                    itemBuilder: (context, index) {
                      final message = socketService.messageList[index];
                      // Updated to use senderId from socket data
                      var senderId = message['senderId'] ?? message['sender'];
                      // Parse and format timestamp
                      String formattedTime = '';
                      try {
                        final timestamp = DateTime.parse(message['createdAt'] ??
                            DateTime.now().toIso8601String());
                        formattedTime =
                            DateFormat('MMM d, HH:mm').format(timestamp);
                      } catch (e) {
                        formattedTime =
                            DateFormat('MMM d, HH:mm').format(DateTime.now());
                      }

                      return Align(
                        alignment: senderId == widget.receiverId
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        child: Column(
                          crossAxisAlignment: senderId == widget.receiverId
                              ? CrossAxisAlignment.start
                              : CrossAxisAlignment.end,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 5.h),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 14.w, vertical: 10.h),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color(0xff9C57FF),
                                    Color.fromARGB(244, 108, 198, 254),
                                  ],
                                ),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: senderId == widget.receiverId
                                      ? Radius.circular(0.r)
                                      : Radius.circular(16.r),
                                  bottomRight: senderId == widget.receiverId
                                      ? Radius.circular(16.r)
                                      : Radius.circular(0.r),
                                  topLeft: Radius.circular(16.r),
                                  topRight: Radius.circular(16.r),
                                ),
                              ),
                              child: Text(
                                message['text'] ?? '',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: senderId == widget.receiverId
                                        ? Colors.black
                                        : Color.fromARGB(255, 253, 253, 252)),
                              ),
                            ),
                            // Updated timestamp display
                            Row(
                              mainAxisAlignment: senderId == widget.receiverId
                                  ? MainAxisAlignment.start
                                  : MainAxisAlignment.end,
                              children: [
                                Text(
                                  formattedTime,
                                  style: TextStyle(
                                      fontSize: 12.sp, color: Colors.white),
                                ),
                                if (senderId != widget.receiverId) ...[
                                  widthBox4,
                                  Icon(
                                    Icons.check,
                                    color: Colors.blue,
                                    size: 18,
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }),
              ),
              // Updated input field to use Form and TextEditingController
              Container(
                height: 70.h,
                padding: EdgeInsets.all(10),
                child: Form(
                  key: _formKey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 280.w,
                        child: ChattingFieldWidget(
                          controller: messageController, // Added controller
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Message cannot be empty';
                            }
                            return null;
                          },
                        ),
                      ),
                      widthBox8,
                      // Updated send button to handle socket-based sending
                      GestureDetector(
                        onTap: isSending || isTextEmpty
                            ? null
                            : () {
                                sendMessageBTN(
                                  widget.chatId,
                                  messageController.text,
                                  widget.receiverId,
                                );
                              },
                        child: Container(
                          height: 50.h,
                          width: 50.h,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(134, 255, 254, 255),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Center(
                            child: isSending
                                ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                        strokeWidth: 2),
                                  )
                                : Icon(
                                    Icons.send,
                                    color: isTextEmpty
                                        ? const Color.fromARGB(
                                            255, 113, 112, 112)
                                        : Colors.blue,
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
