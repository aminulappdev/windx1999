import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:windx1999/app/modules/authentication/views/email_verification_screen.dart';
import 'package:windx1999/app/res/app_images/assets_path.dart';
import 'package:windx1999/app/res/common_widgets/custom_app_bar.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class TwoFactorScreen extends StatefulWidget {
  const TwoFactorScreen({super.key});

  @override
  State<TwoFactorScreen> createState() => _TwoFactorScreenState();
}

class _TwoFactorScreenState extends State<TwoFactorScreen> {
  RxInt remainingTime = 60.obs;
  late Timer timer;
  RxBool enableResendCodeButtom = false.obs;

  @override
  void initState() {
    resendOTP();
    super.initState();
  }

  void resendOTP() {
    enableResendCodeButtom.value = false;
    remainingTime.value = 60;
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (t) {
        remainingTime.value--;
        if (remainingTime.value == 0) {
          t.cancel();
          enableResendCodeButtom.value = true;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomBackground(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(12.0.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 heightBox20,
                  CustomAppBar(title: 'Two-factor authentication'),
                  heightBox40,
                  Text(
                    'Check your email',
                    style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  heightBox12,
                  Text(
                    'Enter the code we sent to na*****3@gmail.com',
                    style: TextStyle(fontSize: 16.sp, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  heightBox40,
                  Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      AssetsPath.twoFactor,
                      height: 228.h,
                      width: 305.w,
                    ),
                  ),
                  heightBox12,
                  Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        heightBox10,
                        TextFormField(
                          decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.white),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(10)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(10)),
                            fillColor: Colors.transparent,
                            hintText: 'Code',
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
                  heightBox14,
                  Obx(
                    () => Row(
                      children: [
                        InkWell(
                          onTap: () {
                            resendOTP();
                          },
                          child: Icon(
                            Icons.refresh,
                            color: Colors.white,
                          ),
                        ),
                        widthBox4,
                        Text(
                          'We can send a new mail in 00:$remainingTime',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  heightBox24,
                  ElevatedButton(
                      onPressed: () {
                        Get.to(EmailVerificationScreen());
                      },
                      child: Text(
                        'Continue',
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
            ),
          ),
        ),
      
    );
  }
}
