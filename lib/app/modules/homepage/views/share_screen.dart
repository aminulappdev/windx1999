import 'package:flutter/material.dart';
import 'package:windx1999/app/res/app_images/assets_path.dart';
import 'package:windx1999/app/res/common_widgets/search_bar.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class ShareScreen extends StatefulWidget {
  const ShareScreen({super.key});

  @override
  State<ShareScreen> createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20,right: 20,left: 20),
            child: Column(
              children: [
                Text(
                  'Links you share are unique to you and may be used to improve suggestions and ads you see. Learn more',
                  style: TextStyle(color: Colors.white),
                ),
                heightBox12,
                CustomSearchBar(),
                heightBox12,
                SizedBox(
                  height: 150,
                  child: GridView.builder(
                    itemCount: 9,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 8,
                      childAspectRatio: 1.5,
                    ),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundImage: AssetImage(AssetsPath.blackGirl),

                          ),
                          heightBox4,
                          Text('Aminul',style: TextStyle(color: Colors.white),)
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 100,
            color: Color(0xffFFFFFF).withOpacity(0.42),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage(AssetsPath.blackGirl),
                      ),
                      Text(
                        'Copy link',
                        style: TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage(AssetsPath.blackGirl),
                      ),
                      Text(
                        'Copy link',
                        style: TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage(AssetsPath.blackGirl),
                      ),
                      Text(
                        'Copy link',
                        style: TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage(AssetsPath.blackGirl),
                      ),
                      Text(
                        'Copy link',
                        style: TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
