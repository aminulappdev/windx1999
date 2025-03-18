import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windx1999/app/modules/homepage/widgets/share_option.dart';
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
      padding: EdgeInsets.all(0.0),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20.h, right: 20.w, left: 20.w),
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
                  height: 150.h,
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
                            radius: 24.r,
                            backgroundImage: AssetImage(AssetsPath.blackGirl),
                          ),
                          heightBox4,
                          Text(
                            'Aminul',
                            style: TextStyle(color: Colors.white),
                          )
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
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 30.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShareOption(
                    bgColor: Color(0xffD1EEFF),
                    
                    title: 'Copy link',
                    ontap: () {},
                    icon: Icons.copy,
                  ),
                  ShareOption(
                    bgColor: Color(0xffD1EEFF),
                    
                    title: 'Add to story',
                    ontap: () {},
                    icon: Icons.add_box,
                  ),
                  ShareOption(
                    bgColor: Color(0xffD1EEFF),
                    imagePath: AssetsPath.fbLogo,
                    title: 'Whatsapp',
                    ontap: () {},
                  ),
                   ShareOption(
                    bgColor: Color(0xffD1EEFF),
                    imagePath: AssetsPath.blackGirl,
                    title: 'Messenger',
                    ontap: () {},
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



