import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:windx1999/app/modules/post/widgets/default_cheker.dart';
import 'package:windx1999/app/modules/post/widgets/privacy_option.dart';
import 'package:windx1999/app/res/common_widgets/custom_app_bar.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/common_widgets/straight_liner.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class PostAudiencesScreen extends StatefulWidget {
  const PostAudiencesScreen({super.key});

  @override
  State<PostAudiencesScreen> createState() => _PostAudiencesScreenState();
}

class _PostAudiencesScreenState extends State<PostAudiencesScreen> {
  String? selectedOption;
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomBackground(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               heightBox20,
                  CustomAppBar(title: 'Post audiences'),
                heightBox50,
                Text(
                  'Who can see your post?',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                heightBox14,
                Text(
                  'Your post may show up in News Feed, on your profile, in search results, and on Messenger\n\nYour default audience is set to Public, but you can change the audience of this specific post',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
                heightBox14,
                Text(
                  'Choose audience',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                heightBox12,
                PrivacyOption(
                  icon: Icons.public,
                  value: 'Public',
                  description: 'Anyone can see your post',
                  groupValue: selectedOption,
                  onChanged: (value) {
                    setState(() {
                      selectedOption = value;
                    });
                  },
                ),
                StraightLiner(),
                PrivacyOption(
                  icon: Icons.group,
                  value: 'Friends',
                  description: 'Your friends on Zheto',
                  groupValue: selectedOption,
                  onChanged: (value) {
                    setState(() {
                      selectedOption = value;
                    });
                  },
                ),
                StraightLiner(),
                PrivacyOption(
                  icon: Icons.group,
                  value: 'Friends except.',
                  description: "Don’t show to same friends",
                  groupValue: selectedOption,
                  onChanged: (value) {
                    setState(() {
                      selectedOption = value;
                    });
                  },
                  hasArrow: true,
                ),
                StraightLiner(),
                PrivacyOption(
                  icon: Icons.lock,
                  value: 'Only me',
                  description: 'Only you can see',
                  groupValue: selectedOption,
                  onChanged: (value) {
                    setState(() {
                      selectedOption = value;
                    });
                  },
                ),
                StraightLiner(),
                heightBox30,
                DefaultCheker(
                  isChecked: isChecked,
                  ontap: () {
                    setState(() {
                      isChecked = !isChecked;
                    });
                  },
                ),
                heightBox14,
                ElevatedButton(onPressed: (){
                  Get.back();
                }, child: Text('Done',style: TextStyle(color: Colors.white),))
              ],
            ),
          ),
        ),
      
    );
  }
}
