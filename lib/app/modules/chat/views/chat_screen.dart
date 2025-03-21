import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:windx1999/app/modules/chat/views/action_screen.dart';
import 'package:windx1999/app/modules/chat/widgets/chat_appBar.dart';
import 'package:windx1999/app/modules/chat/widgets/chat_field.dart';
import 'package:windx1999/app/res/app_images/assets_path.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/common_widgets/liner_widget.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class ChatScreen extends StatefulWidget {
 
  const ChatScreen({
    super.key,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<CameraDescription>? cameras;
  final List<Map<String, dynamic>> messageList = [
    {
      "text": "I have some loads, can you transfer them to Dhaka safely?",
      "isSent": true
    },
    {"text": "Oh it’s okay.", "isSent": false},
    {"text": "Next time, we will meet again", "isSent": true},
    {"text": "Oh it’s okay i like it too babe", "isSent": false},
    {"text": "Okay see you soon very soon", "isSent": true},
  ];

  @override
  void initState() {
    super.initState();
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
                CustomChatAppBar(
                  name: 'Dr. Jane Smith',
                  imagePath: AssetsPath.blackGirl,
                  activeStatus: 'Active',
                  isActive: true,
                  actionOntap: () {               
                    Get.to(ActionScreen());
                  },
                ),
                Liner(text: 'Today'),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(10.r),
                    itemCount: messageList.length,
                    itemBuilder: (context, index) {
                      final message = messageList[index];
                      return Align(
                        alignment: message['isSent']
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: message['isSent']
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
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
                                  bottomLeft: message['isSent']
                                      ? Radius.circular(16.r)
                                      : Radius.circular(0.r),
                                  bottomRight: message['isSent']
                                      ? Radius.circular(0.r)
                                      : Radius.circular(16.r),
                                  topLeft: Radius.circular(16.r),
                                  topRight: Radius.circular(16.r),
                                ),
                              ),
                              child: Text(
                                message['text'],
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: message['isSent']
                                        ? Color.fromARGB(255, 253, 253, 252)
                                        : Colors.black),
                              ),
                            ),
                            message['isSent']
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        '11:30 AM',
                                        style: TextStyle(
                                            fontSize: 12.sp, color: Colors.white),
                                      ),
                                      widthBox4,
                                      Icon(
                                        Icons.check,
                                        color: Colors.blue,
                                        size: 18,
                                      )
                                    ],
                                  )
                                : Text(
                                    '11:30 AM',
                                    style: TextStyle(
                                        fontSize: 12.sp, color: Colors.white),
                                  ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  height: 70.h,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 280.w,
                        child: ChattingFieldWidget(),
                      ),
                      widthBox8,
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 50.h,
                          width: 50.h,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(134, 255, 254, 255),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.send,
                              color: const Color.fromARGB(255, 113, 112, 112),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      
    );
  }
}
