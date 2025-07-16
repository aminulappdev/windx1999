// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:windx1999/app/res/app_images/assets_path.dart';
// import 'package:windx1999/app/res/common_widgets/custom_app_bar.dart';
// import 'package:windx1999/app/res/common_widgets/custom_background.dart';
// import 'package:windx1999/app/res/common_widgets/custom_rectangle_buttom.dart';
// import 'package:windx1999/app/res/custom_style/custom_size.dart';

// class NotificationScreen extends StatefulWidget {
//   const NotificationScreen({super.key});

//   @override
//   State<NotificationScreen> createState() => _NotificationScreenState();
// }

// ignore_for_file: unused_local_variable, depend_on_referenced_packages

// class _NotificationScreenState extends State<NotificationScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//       body: CustomBackground(
//         child: Padding(
//           padding:  EdgeInsets.all(20.0.h),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//              heightBox20,
//                   CustomAppBar(title: 'Notification'),
//               heightBox50,
//               Text(
//                 'Today',
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 20.sp,
//                     fontWeight: FontWeight.w600),
//               ),
//               heightBox12,
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: 6,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       contentPadding: EdgeInsets.all(0),
//                       leading: CircleAvatar(
//                         backgroundImage: AssetImage(AssetsPath.blackGirl),
//                       ),
//                       title: Text(
//                         'Aminul islam',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       subtitle: Text(
//                         'Aminul islam messeage',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       trailing: CustomRectangleButton(
//                           bgColor: Color(0xff6CC7FE),
//                           height: 36.h,
//                           width: 97.w,
//                           radiusSize: 12,
//                           textColor: Colors.white,
//                           textSize: 12.sp,
//                           text: 'Follow back',
//                           ontap: () {}),
//                     );
//                   },
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     ));
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:windx1999/app/modules/homepage/controller/all_notification_controller.dart';
import 'package:windx1999/app/res/common_widgets/custom_app_bar.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';
import 'package:windx1999/app/services/socket/socket_service.dart'; // Socket service
import 'package:windx1999/get_storage.dart'; // For user ID
import 'package:windx1999/app/modules/profile/controllers/profile_controller.dart'; // For user data
import 'package:intl/intl.dart'; // For formatting timestamps

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // Initialize controllers and services
  final SocketService socketService = Get.find<SocketService>();
  final ProfileController profileController = Get.find<ProfileController>();
  final AllNotificationController notificationController =
      Get.put(AllNotificationController());
  late String userId;

  @override
  void initState() {
    super.initState();
    // Get the user ID from storage
    userId = StorageUtil.getData(StorageUtil.userId) ?? '';

    // Initialize socket connection if not already initialized
    socketService.init();

    // Listen for incoming notifications
    socketService.sokect.on('notification::$userId', (data) {
      print('New notification received: $data');
      _handleIncomingNotification(data);
    });

    // Fetch initial notifications
    notificationController.getAllNotification();
  }

  @override
  void dispose() {
    // Clean up socket listeners
    socketService.sokect.off('new-notification::$userId');
    super.dispose();
  }

  // Handle incoming notifications from socket
  void _handleIncomingNotification(dynamic data) {
    if (data['createdAt'] == null) {
      data['createdAt'] = DateTime.now().toIso8601String();
    }
    notificationController.notificationList.add(data);
    setState(() {}); // Update UI when new notification arrives
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        child: Padding(
          padding: EdgeInsets.all(20.0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heightBox20,
              CustomAppBar(title: 'Notification'),

              // Text(
              //   'Today',
              //   style: TextStyle(
              //     color: Colors.white,
              //     fontSize: 20.sp,
              //     fontWeight: FontWeight.w600,
              //   ),
              // ),
              // heightBox12,
              heightBox10,
              Expanded(
                child: Obx(() {
                  if (notificationController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (socketService.notificationsList.isEmpty) {
                    return const Center(child: Text('No Nofification Found'));
                  }

                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: socketService.notificationsList.length,
                    itemBuilder: (context, index) {
                      final notification =
                          socketService.notificationsList[index];

                      // Parse and format timestamp
                      String formattedTime = '';
                      try {
                        final timestamp = DateTime.parse(
                            notification['createdAt'] ??
                                DateTime.now().toIso8601String());
                        formattedTime =
                            DateFormat('MMM d, HH:mm').format(timestamp);
                      } catch (e) {
                        formattedTime =
                            DateFormat('MMM d, HH:mm').format(DateTime.now());
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            child: ListTile(
                              contentPadding: EdgeInsets.all(0),
                              // leading: CircleAvatar(
                              //   backgroundImage:
                              //       notification['senderImage'] != null &&
                              //               notification['senderImage'].isNotEmpty
                              //           ? NetworkImage(notification['senderImage'])
                              //           : AssetImage(AssetsPath.blackGirl),
                              // ),
                              title: Text(
                                notification['message'] ?? 'Unknown',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                              subtitle: Text(
                                notification['description'] ?? 'No message',
                                style: TextStyle(color: Colors.white),
                              ),
                              // trailing: CustomRectangleButton(
                              //   bgColor: Color(0xff6CC7FE),
                              //   height: 36.h,
                              //   width: 97.w,
                              //   radiusSize: 12,
                              //   textColor: Colors.white,
                              //   textSize: 12.sp,
                              //   text: 'Follow back',
                              //   ontap: () {
                              //     // Implement follow-back functionality if needed
                              //     // Example: Emit socket event or call controller method
                              //   },
                              // ),
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
