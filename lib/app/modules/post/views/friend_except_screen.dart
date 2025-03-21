import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windx1999/app/res/common_widgets/custom_app_bar.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/common_widgets/search_bar.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class FriendExceptScreen extends StatefulWidget {
  const FriendExceptScreen({super.key});

  @override
  State<FriendExceptScreen> createState() => _FriendExceptScreenState();
}

class _FriendExceptScreenState extends State<FriendExceptScreen> {
  final List<Map<String, String>> users = [
    {'name': 'Nammi', 'image': 'https://randomuser.me/api/portraits/men/1.jpg'},
    {
      'name': 'Shelly Shila',
      'image': 'https://randomuser.me/api/portraits/women/1.jpg'
    },
    {
      'name': 'Muskan',
      'image': 'https://randomuser.me/api/portraits/women/2.jpg'
    },
    {'name': 'Tonni', 'image': 'https://randomuser.me/api/portraits/men/2.jpg'},
    {
      'name': 'Lamiya',
      'image': 'https://randomuser.me/api/portraits/women/3.jpg'
    },
  ];

  // Keeps track of the selected users
  List<String> selectedUsers = [];

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
                  CustomAppBar(title: 'Friends except'),
                heightBox20,
                CustomSearchBar(),
                heightBox12,
                Expanded(
                  child: ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];
                      return ListTile(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
                        leading: CircleAvatar(
                          radius: 25.r,
                          backgroundImage: NetworkImage(user['image']!),
                        ),
                        title: Text(
                          user['name']!,
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            selectedUsers.contains(user['name'])
                                ? Icons.check_circle
                                : Icons.check_circle_outline,
                            color: selectedUsers.contains(user['name'])
                                ? Colors.blue
                                : Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              if (selectedUsers.contains(user['name'])) {
                                selectedUsers.remove(user['name']);
                              } else {
                                selectedUsers.add(user['name']!);
                              }
                            });
                          },
                        ),
                        tileColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      
    );
  }
}
