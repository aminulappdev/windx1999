import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:windx1999/app/modules/authentication/views/email_verification_screen.dart';
import 'package:windx1999/app/res/app_images/assets_path.dart';
import 'package:windx1999/app/res/common_widgets/custom_app_bar.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class ForgotpasswordScreen extends StatefulWidget {
  const ForgotpasswordScreen({super.key});

  @override
  State<ForgotpasswordScreen> createState() => _ForgotpasswordScreenState();
}

class _ForgotpasswordScreenState extends State<ForgotpasswordScreen> {
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
        body: CustomBackground(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(12.0.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                 heightBox20,
                  CustomAppBar(title: 'Forgot Password'),
                  heightBox40,
                  SvgPicture.asset(
                    AssetsPath.forgotPass,
                    height: 228.h,
                    width: 305.w,
                  ),
                  heightBox40,
                  Text(
                    'Please enter your email address which was used to create your account',
                    style: TextStyle(fontSize: 16.sp, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  heightBox12,
                  Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email',
                          style: TextStyle(fontSize: 16.sp, color: Colors.white),
                        ),
                        heightBox10,
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Enter your email',
                            errorStyle: TextStyle(
                                color: const Color.fromARGB(255, 237, 82, 82)),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.emailAddress,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Enter email';
                            }
                    
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  heightBox24,
                  ElevatedButton(onPressed: () {
                    Get.to(EmailVerificationScreen());
                  }, child: Text('Next'))
                ],
              ),
            ),
          ),
        ),
      
    );
  }
}
