import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:windx1999/app/modules/authentication/controllers/forgot_email_controller.dart';
import 'package:windx1999/app/modules/authentication/views/forgot_email_verification_screen.dart';
import 'package:windx1999/app/res/app_images/assets_path.dart';
import 'package:windx1999/app/res/common_widgets/custom_app_bar.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/common_widgets/custom_snackbar.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class ForgotpasswordScreen extends StatefulWidget {
  const ForgotpasswordScreen({super.key});

  @override
  State<ForgotpasswordScreen> createState() => _ForgotpasswordScreenState();
}

class _ForgotpasswordScreenState extends State<ForgotpasswordScreen> {
  final TextEditingController emailCtrl = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ForgotEmailController forgotEmailController =
      Get.put(ForgotEmailController());

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
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email',
                        style: TextStyle(fontSize: 16.sp, color: Colors.white),
                      ),
                      heightBox10,
                      TextFormField(
                        controller: emailCtrl,
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
                GetBuilder<ForgotEmailController>(
                  builder: (controller) {
                    return ElevatedButton(
                      onPressed: controller.inProgress
                          ? null
                          : () async {
                              if (_formKey.currentState!.validate()) {
                                await otpBTN(emailCtrl.text);
                              }
                            },
                      child: controller.inProgress
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text('Next'),
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

  Future<void> otpBTN(String email) async {
    final bool isSuccess = await forgotEmailController.forgotEmail(email);

    if (isSuccess) {
      if (mounted) {
        showSnackBarMessage(context, 'Successfully done');
        var token = forgotEmailController.forgotData?.token ?? 'Empty';
        print('Token is $token');
        Get.to(() => ForgotEmailVerificationScreen(
              email: email,
              accessToken: token,
            ));
      }
    } else {
      if (mounted) {
        showSnackBarMessage(context,
            forgotEmailController.errorMessage ?? 'Failed to send OTP', true);
      }
    }
  }
}
