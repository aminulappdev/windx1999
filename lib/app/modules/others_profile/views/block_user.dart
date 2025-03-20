import 'package:flutter/material.dart';
import 'package:windx1999/app/res/app_images/assets_path.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class BlockUserScreen extends StatefulWidget {
  const BlockUserScreen({super.key});

  @override
  State<BlockUserScreen> createState() => _BlockUserScreenState();
}

class _BlockUserScreenState extends State<BlockUserScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(AssetsPath.blackGirl),
                ),
              ),
              heightBox14,
              Text(
                'Block Muskan?',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              heightBox20,
              Text(
                'This will also block any other accounts they may have or create in the future.',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
              heightBox20,
              Row(
                children: [
                  Icon(
                    Icons.person_remove,
                    color: Colors.white,
                  ),
                  widthBox8,
                  SizedBox(
                    width: 300,
                    child: Text(
                      'This will also block any other accounts they may have or create in the future.',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
              heightBox14,
              Row(
                children: [
                  Icon(
                    Icons.notifications_off,
                    color: Colors.white,
                  ),
                  widthBox8,
                  SizedBox(
                    width: 300,
                    child: Text(
                      'This will also block any other accounts they may have or create in the future.',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
              heightBox20,
              ElevatedButton(onPressed: () {
                
              }, child: Text('Block',style: TextStyle(color: Colors.white),))
            ],
          ),
        ),
      ),
    );
  }
}
