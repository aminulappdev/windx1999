import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:windx1999/app/modules/profile/views/add_account.dart';
import 'package:windx1999/app/modules/profile/views/block_account_screen.dart';
import 'package:windx1999/app/modules/profile/views/save_items.dart';
import 'package:windx1999/app/modules/profile/views/your_account.dart';
import 'package:windx1999/app/res/common_widgets/custom_app_bar.dart';
import 'package:windx1999/app/res/common_widgets/custom_dialoge.dart';
import 'package:windx1999/app/res/common_widgets/straight_liner.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width / 1.3,
      child: Drawer(
        backgroundColor: Color(0xffA386F0),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  heightBox16,
                  CustomAppBar(title: 'Settings'),
                  heightBox40,
                  costomRow(context, Icons.person, 'Your Account',
                      Icons.arrow_forward_ios, () {
                    showModalBottomSheet(
                      scrollControlDisabledMaxHeightRatio: 0.6,
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      backgroundColor: Color(0xffA96CFF),
                      builder: (context) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [YourAccount()],
                        );
                      },
                    );
                  }),
                  heightBox20,
                  costomRow(
                      context, Icons.bookmark, 'Saved', Icons.arrow_forward_ios,
                      () {
                    Get.to(SaveItemScreen());
                  }),
                  heightBox20,
                  costomRow(context, Icons.person_off, 'Blocked',
                      Icons.arrow_forward_ios, () {
                    Get.to(BlockScreen());
                  }),
                  SizedBox(
                    height: 50.h,
                  ),
                  costomRow(context, Icons.person, 'Add Account',
                      Icons.arrow_forward_ios, () {
                        showModalBottomSheet(
                      scrollControlDisabledMaxHeightRatio: 0.6,
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      backgroundColor: Color(0xffA96CFF),
                      builder: (context) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [AddAccount()],
                        );
                      },
                    );
                      }),
                  heightBox20,
                  costomRow(context, Icons.bookmark, 'Logout',
                      Icons.arrow_forward_ios, () {
                         _showDeleteAccountDialog(context);
                      }),
                  heightBox20,
                  costomRow(context, Icons.person_off, 'Delete Account',
                      Icons.arrow_forward_ios, () {
                        _showLogoutDialog(context);
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );

   
  }


 void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDeleteDialog(
          noOntap: () {
            
            Navigator.pop(context); 
          },
          yesOntap: () {
            Navigator.pop(context); 
          }, iconData: Icons.logout,
          subtitle: 'Do you want to log out this profile?',title: 'Delete',
        );
      },
    );
  }
  
   void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDeleteDialog(
          noOntap: () {
            
            Navigator.pop(context); 
          },
          yesOntap: () {
            Navigator.pop(context); 
          }, iconData: Icons.delete,
          subtitle: 'Do you want to delete this profile?', title: 'Logout',
        );
      },
    );
  }
 
  Widget costomRow(BuildContext context, IconData circleIcon, String name,
      IconData? icon, VoidCallback navigator,
      {IconData? newIcon}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: navigator,
              child: Row(
                children: [
                  Icon(
                    size: 24.h,
                    circleIcon,
                    color: Colors.white,
                  ),
                  widthBox12,
                  Text(
                    name,
                    style: GoogleFonts.notoSansMyanmar(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  )
                ],
              ),
            ),
            Icon(
              icon,
              color: Colors.white,
            )
          ],
        ),
        heightBox8,
        StraightLiner()
      ],
    );
  }
}
