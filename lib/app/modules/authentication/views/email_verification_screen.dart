import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:windx1999/app/modules/authentication/controllers/create_user_controller.dart';
import 'package:windx1999/app/modules/authentication/controllers/otp_verify_controller.dart';
import 'package:windx1999/app/modules/authentication/widgets/resend_code.dart';
import 'package:windx1999/app/modules/profile/views/set_up/profile_setup_screen.dart';
import 'package:windx1999/app/res/app_images/assets_path.dart';
import 'package:windx1999/app/res/common_widgets/custom_app_bar.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/common_widgets/custom_snackbar.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';
import 'package:windx1999/get_storage.dart';

class EmailVerificationScreen extends StatefulWidget {
  final String accessToken;
  const EmailVerificationScreen({super.key, required this.accessToken});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final TextEditingController otpCtrl = TextEditingController();
  final OtpVerifyController otpVerifyController = OtpVerifyController();
  final CreateUserController createUserController = Get.find<CreateUserController>();

  @override
  void initState() {
    super.initState();
    // ডিবাগ: স্ক্রিন লোড হওয়ার সময় ডাটা চেক
    
    print('Initial userData: ${createUserController.userData}');
    print('Initial otpToken: ${createUserController.otpToken}');
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
                  'Please enter the 4 digit code that was sent to xyz@gmail.com ',
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
                              inactiveColor: const Color.fromARGB(218, 222, 220, 220),
                              fieldHeight: 50.h,
                              fieldWidth: 50.h,
                              activeFillColor: Colors.white,
                              inactiveFillColor: Colors.white,
                              selectedFillColor: Colors.white),
                          animationDuration: const Duration(milliseconds: 300),
                          backgroundColor: Colors.transparent,
                          enableActiveFill: true,
                          appContext: context,
                        ),
                      ),
                    ],
                  ),
                ),
                heightBox12,
                ResendCode(
                  fTextName: 'Don’t received code! ',
                  fTextColor: Colors.white,
                  sTextName: 'Resend code?',
                  sTextColor: const Color(0xff6CC7FE),
                  ontap: () {},
                ),
                heightBox24,
                GetBuilder<CreateUserController>(
                  builder: (controller) {
                    var token = controller.userData?.otpToken?.token ?? 'Empty token';
                    return ElevatedButton(
                      onPressed: () {
                        otpBTN(otpCtrl.text, StorageUtil.getData('user-otp-token'));
                      },
                      child: const Text('Confirm'),
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
        // print('user id : $userId');
        Get.to(ProfileSetupScreen(
          userId: userId ?? 'Empty',
        ));
      }

      showSnackBarMessage(context, 'Register successfully done');
      // নেভিগেশন: আপনার অ্যাপের হোম রাউটে
      // Get.offAllNamed('/home'); // আপনার রাউট অনুযায়ী পরিবর্তন করুন

    } else {
      showSnackBarMessage(
          context, otpVerifyController.errorMessage ?? 'Verification failed', true);
    }
  }
}