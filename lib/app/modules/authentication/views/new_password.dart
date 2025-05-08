import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:windx1999/app/modules/authentication/controllers/reset_password_controller.dart';
import 'package:windx1999/app/modules/authentication/views/log_in_screen.dart';
import 'package:windx1999/app/res/app_images/assets_path.dart';
import 'package:windx1999/app/res/common_widgets/custom_app_bar.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/common_widgets/custom_snackbar.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String otpToken;
  const ResetPasswordScreen({super.key, required this.otpToken});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController confirmPasswordCtrl = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ResetPasswordController resetPasswordController =
      ResetPasswordController();

  bool _obscureText = true;
  bool _obscureConfirmText = true;

  @override
  void initState() {
    print('Initalize pase otp token : ${widget.otpToken}');
    super.initState();
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
                CustomAppBar(title: 'New Password'),
                heightBox40,
                SvgPicture.asset(
                  AssetsPath.newPass,
                  height: 228.h,
                  width: 305.w,
                ),
                heightBox40,
                Text(
                  'Please create and enter a new password for your account',
                  style: TextStyle(fontSize: 16.sp, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                heightBox30,
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Password',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      heightBox10,
                      TextFormField(
                        controller: passwordCtrl,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Enter password';
                          }
                          return null;
                        },
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          errorStyle: TextStyle(
                              color: const Color.fromARGB(255, 237, 82, 82)),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                          hintText: 'Enter your password',
                        ),
                      ),
                      heightBox24,
                      Text(
                        'Confirm password',
                        style: TextStyle(fontSize: 16.sp, color: Colors.white),
                      ),
                      heightBox10,
                      TextFormField(
                        controller: confirmPasswordCtrl,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Enter confirm password';
                          }
                          return null;
                        },
                        obscureText: _obscureConfirmText,
                        decoration: InputDecoration(
                          errorStyle: TextStyle(
                              color: const Color.fromARGB(255, 237, 82, 82)),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureConfirmText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureConfirmText = !_obscureConfirmText;
                              });
                            },
                          ),
                          hintText: 'Enter confirm password',
                        ),
                      ),
                    ],
                  ),
                ),
                heightBox24,
                ElevatedButton(
                    onPressed: () {
                      resetPasswordBTN(
                          passwordCtrl.text, confirmPasswordCtrl.text);
                    },
                    child: Text('Save'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> resetPasswordBTN(String password, String confirmPassword,) async {
    final bool isSuccess =
        await resetPasswordController.resetPassword(password, confirmPassword, widget.otpToken);

    if (isSuccess) {
      if (mounted) {
        showSnackBarMessage(context, 'Successfully done');

        Get.to(LogInScreen());
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, resetPasswordController.errorMessage ?? 'failed', true);
      }
    }
  }
}
