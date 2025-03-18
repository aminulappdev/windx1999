import 'package:flutter/material.dart';
import 'package:windx1999/app/res/app_images/assets_path.dart';
import 'package:windx1999/app/res/common_widgets/custom_app_bar.dart';
import 'package:windx1999/app/res/common_widgets/drop_down.dart';
import 'package:windx1999/app/res/common_widgets/straight_liner.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(title: 'New post'),
              heightBox20,
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(AssetsPath.blackGirl),
                  ),
                  widthBox5,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nammi Fatema',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      heightBox4,
                      DropDownButton(
                        option: [
                          {'name': 'Public', 'icon': Icons.public},
                          {'name': 'Friends', 'icon': Icons.group},
                          {'name': 'Friends except', 'icon': Icons.public},
                          {'name': 'Only me', 'icon': Icons.lock},
                        ],
                      )
                    ],
                  )
                ],
              ),
              heightBox20,
              TextFormField(
                maxLines: 4,
                decoration: InputDecoration(
                    fillColor: const Color.fromARGB(166, 255, 255, 255),
                    hintText: 'Type your status here..',
                    hintStyle: TextStyle(fontSize: 16, color: Colors.white)),
              ),
              heightBox12,
              StraightLiner(),
              heightBox8,
              InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    Icon(
                      Icons.photo,
                      size: 24,
                      color: Colors.white,
                    ),
                    widthBox4,
                    Text(
                      'Photos/videos',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    )
                  ],
                ),
              ),
              heightBox12,
              StraightLiner(),
              heightBox8,
              InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    Icon(
                      Icons.movie,
                      size: 24,
                      color: Colors.white,
                    ),
                    widthBox4,
                    Text(
                      'Reels',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
