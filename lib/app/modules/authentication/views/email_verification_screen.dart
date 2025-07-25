// ignore_for_file: avoid_print

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:windx1999/app/modules/authentication/controllers/create_user_controller.dart';
import 'package:windx1999/app/modules/authentication/controllers/otp_verify_controller.dart';
import 'package:windx1999/app/modules/authentication/controllers/resend_otp_controller.dart';
import 'package:windx1999/app/modules/authentication/widgets/resend_code.dart';
import 'package:windx1999/app/modules/profile/views/set_up/profile_setup_screen.dart';
import 'package:windx1999/app/res/app_images/assets_path.dart';
import 'package:windx1999/app/res/common_widgets/custom_app_bar.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/common_widgets/custom_snackbar.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class EmailVerificationScreen extends StatefulWidget {
  final String accessToken;
  final String email;
  const EmailVerificationScreen({super.key, required this.accessToken, required this.email});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final TextEditingController otpCtrl = TextEditingController();
  final OtpVerifyController otpVerifyController = Get.put(OtpVerifyController());
  final CreateUserController createUserController =
      Get.find<CreateUserController>();
  final ResendOtpController resendOtpController = ResendOtpController();

  RxInt remainingTime = 60.obs;
  late Timer timer;
  RxBool enableResendCodeButton = false.obs;

  @override
  void initState() {
    super.initState();
    print('Initial userData: ${createUserController.userData}');
    print('Initial otpToken: ${createUserController.otpToken}');

    // Start the timer without calling resendOTP
    remainingTime.value = 60;
    enableResendCodeButton.value = false;
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (t) {
        remainingTime.value--;
        if (remainingTime.value == 0) {
          t.cancel();
          enableResendCodeButton.value = true;
        }
      },
    );
  }

  void resendOTP() async {
    print('resendOTP called'); // For debugging
    enableResendCodeButton.value = false;
    remainingTime.value = 60;
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (t) {
        remainingTime.value--;
        if (remainingTime.value == 0) {
          t.cancel();
          enableResendCodeButton.value = true;
        }
      },
    );
  
    final bool isSuccess = await resendOtpController.resendOtp(widget.email);

    if (isSuccess) {
      if (mounted) {
        showSnackBarMessage(context, 'OTP Successfully sent');
        clearTextField(); // Clear OTP field after successful resend
      }
    } else {
      if (mounted) {
        showSnackBarMessage(context,
            resendOtpController.errorMessage ?? 'Failed to resend OTP', true);
      }
    }
  }

  void clearTextField() {
    otpCtrl.clear();
    setState(() {}); // Update UI to reflect cleared field
  }

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
                CustomAppBar(title: 'Email Verification'),
                heightBox40,
                SvgPicture.asset(
                  AssetsPath.emailVer,
                  height: 228.h,
                  width: 305.w,
                ),
                heightBox40,
                Text(
                  'Please enter the 6 digit code that was sent',
                  style: TextStyle(fontSize: 16.sp, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                heightBox30,
                Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: PinCodeTextField(
                          controller: otpCtrl,
                          length: 6,
                          animationType: AnimationType.fade,
                          keyboardType: TextInputType.number,
                          pinTheme: PinTheme(
                              borderWidth: 0.2,
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(12.r),
                              inactiveColor:
                                  const Color.fromARGB(218, 222, 220, 220),
                              fieldHeight: 50.h,
                              fieldWidth: 50.h,
                              activeFillColor: Colors.white,
                              inactiveFillColor: Colors.white,
                              selectedFillColor: Colors.white),
                          animationDuration: const Duration(milliseconds: 300),
                          backgroundColor: Colors.transparent,
                          enableActiveFill: true,
                          appContext: context,
                          onChanged: (value) {
                            setState(() {}); // Update UI on OTP change
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                heightBox12,
                Obx(
                  () => Visibility(
                    visible: !enableResendCodeButton.value,
                    replacement: ResendCode(
                      fTextName: 'Don’t received code! ',
                      fTextColor: Colors.white,
                      sTextName: 'Resend code?',
                      sTextColor: const Color(0xff6CC7FE),
                      ontap: () {
                        resendOTP();
                      },
                    ),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Resend code in ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                            ),
                          ),
                          TextSpan(
                            text: ' ${remainingTime.value}',
                            style: TextStyle(
                              color: const Color(0xff6CC7FE),
                              fontSize: 16.sp,
                            ),
                          ),
                          TextSpan(
                            text: 's',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                heightBox24,
                GetBuilder<OtpVerifyController>(
                  builder: (controller) {
                    var token =
                        createUserController.userData?.otpToken?.token ?? widget.accessToken;
                    return ElevatedButton(
                      onPressed: otpCtrl.text.length == 6 && !controller.inProgress
                          ? () => otpBTN(otpCtrl.text, token)
                          : null, // Disable button if OTP is not 6 digits or inProgress is true
                      child: controller.inProgress
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text('Confirm'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> otpBTN(String otp, String token) async {
    final bool isSuccess = await otpVerifyController.otpVerify(otp, token);
    if (isSuccess) {
      if (mounted) {
        showSnackBarMessage(context, 'Register successfully done');
        var userId = otpVerifyController.otpData?.user?.id;
        Get.to(() => ProfileSetupScreen(
              userId: userId ?? 'Empty',
            ));
      }
    } else {
      if (mounted) {
        showSnackBarMessage(context,
            otpVerifyController.errorMessage ?? 'Verification failed', true);
      }
    }
  }

  @override
  void dispose() {
    timer.cancel();
    otpCtrl.dispose();
    super.dispose();
  }
}