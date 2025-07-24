import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:windx1999/app/modules/authentication/controllers/create_user_controller.dart';
import 'package:windx1999/app/modules/authentication/controllers/forgot_email_controller.dart';
import 'package:windx1999/app/modules/authentication/controllers/forgot_otp_verify_controller.dart';
import 'package:windx1999/app/modules/authentication/controllers/resend_otp_controller.dart';
import 'package:windx1999/app/modules/authentication/views/new_password.dart';
import 'package:windx1999/app/res/app_images/assets_path.dart';
import 'package:windx1999/app/res/common_widgets/custom_app_bar.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/common_widgets/custom_snackbar.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class ForgotEmailVerificationScreen extends StatefulWidget {
  final String accessToken;
  const ForgotEmailVerificationScreen({super.key, required this.accessToken});

  @override
  State<ForgotEmailVerificationScreen> createState() =>
      _ForgotEmailVerificationScreenState();
}

class _ForgotEmailVerificationScreenState
    extends State<ForgotEmailVerificationScreen> {
  final TextEditingController otpCtrl = TextEditingController();
  final ForgotEmailController forgotEmailController =
      Get.find<ForgotEmailController>();
  final CreateUserController createUserController =
      Get.find<CreateUserController>();
  final ForgotOtpVerifyController forgotOtpVerifyController =
      ForgotOtpVerifyController();
  final ResendOtpController resendOtpController = ResendOtpController();

  RxInt remainingTime = 60.obs;
  late Timer timer;
  RxBool enableResendCodeButton = false.obs;

  @override
  void initState() {
    super.initState();
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

    // Assuming forgotEmailController has a method to resend OTP
    final bool isSuccess = await resendOtpController.resendOtp('');

    if (isSuccess) {
      if (mounted) {
        showSnackBarMessage(context, 'OTP Successfully sent');
        clearTextField(); // Clear OTP field after successful resend
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, forgotEmailController.errorMessage ?? 'Failed to resend OTP',
            true);
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
            child: GetBuilder<ForgotEmailController>(builder: (controller) {
              return Column(
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
                      replacement: GestureDetector(
                        onTap: () {
                          resendOTP();
                        },
                        child: Text(
                          'Resend code',
                          style: TextStyle(
                            color: Color(0xff6CC7FE),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
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
                              text: '${remainingTime.value}',
                              style: TextStyle(
                                color: Color(0xff6CC7FE),
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
                  ElevatedButton(
                    onPressed: otpCtrl.text.length == 6
                        ? () => otpBTN(otpCtrl.text)
                        : null, // Disable button if OTP is not 6 digits
                    child: Text('Confirm'),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Future<void> otpBTN(String otp) async {
    var token = widget.accessToken;
    print('OTP Button token : $token');

    final bool isSuccess =
        await forgotOtpVerifyController.forgotOtpVerify(otp, token);

    if (isSuccess) {
      if (mounted) {
        showSnackBarMessage(context, 'Successfully done');
        var otpVerifyToken =
            forgotOtpVerifyController.otpData!.token ?? 'empty';
        Get.to(ResetPasswordScreen(
          otpToken: otpVerifyToken,
        ));
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, forgotOtpVerifyController.errorMessage ?? 'failed', true);
      }
    }
  }

  @override
  void dispose() {
    timer.cancel(); // Prevent memory leaks
    otpCtrl.dispose();
    super.dispose();
  }
}