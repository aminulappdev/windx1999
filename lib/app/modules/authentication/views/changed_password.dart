import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:windx1999/app/modules/authentication/controllers/change_password_controller.dart';
import 'package:windx1999/app/modules/authentication/views/forgot_password_screen.dart'; // Fixed import typo
import 'package:windx1999/app/modules/profile/views/profile_screen.dart';
import 'package:windx1999/app/res/common_widgets/custom_app_bar.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/common_widgets/custom_snackbar.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class ChangedPasswordScreen extends StatefulWidget {
  const ChangedPasswordScreen({super.key});

  @override
  State<ChangedPasswordScreen> createState() => _ChangedPasswordScreenState();
}

class _ChangedPasswordScreenState extends State<ChangedPasswordScreen> {
  bool _obscureText = true;
  bool _obscureConfirmText = true;

  final _globalKey = GlobalKey<FormState>();
  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final ChangePasswordController changePasswordController = Get.put(ChangePasswordController());

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
                CustomAppBar(title: 'Change Password'), // Fixed title typo
                heightBox40,
                Text(
                  'Your password must be at least 6 characters and should include a combination of numbers, letters, and special characters.',
                  style: TextStyle(fontSize: 16.sp, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                heightBox30,
                Form(
                  key: _globalKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Current Password',
                        style: TextStyle(fontSize: 16.sp, color: Colors.white),
                      ),
                      heightBox10,
                      TextFormField(
                        controller: currentPasswordController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter current password';
                          }
                          return null;
                        },
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          errorStyle: const TextStyle(
                              color: Color.fromARGB(255, 237, 82, 82)),
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
                          hintText: 'Enter your current password',
                        ),
                      ),
                      heightBox24,
                      Text(
                        'New Password',
                        style: TextStyle(fontSize: 16.sp, color: Colors.white),
                      ),
                      heightBox10,
                      TextFormField(
                        controller: newPasswordController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter new password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          errorStyle: const TextStyle(
                              color: Color.fromARGB(255, 237, 82, 82)),
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
                          hintText: 'Enter your new password',
                        ),
                      ),
                      heightBox24,
                      Text(
                        'Confirm New Password',
                        style: TextStyle(fontSize: 16.sp, color: Colors.white),
                      ),
                      heightBox10,
                      TextFormField(
                        controller: confirmPasswordController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter confirm password';
                          }
                          if (value != newPasswordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                        obscureText: _obscureConfirmText,
                        decoration: InputDecoration(
                          errorStyle: const TextStyle(
                              color: Color.fromARGB(255, 237, 82, 82)),
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
                          hintText: 'Confirm your new password',
                        ),
                      ),
                      heightBox12,
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const ForgotpasswordScreen()); // Fixed typo in class name
                        },
                        child: Text(
                          'Forgot password?',
                          style: TextStyle(fontSize: 16.sp, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                heightBox24,
                GetBuilder<ChangePasswordController>(
                  builder: (controller) {
                    return ElevatedButton(
                      onPressed: controller.inProgress
                          ? null
                          : () async {
                              if (_globalKey.currentState!.validate()) {
                                await changePassword(
                                  currentPasswordController.text,
                                  newPasswordController.text,
                                  confirmPasswordController.text,
                                );
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
                          : const Text(
                              'Change Password',
                              style: TextStyle(color: Colors.white),
                            ),
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

  Future<void> changePassword(
    String currentPassword,
    String newPassword,
    String confirmPassword,
  ) async {
    final bool isSuccess = await changePasswordController.changePassword(
      currentPassword,
      newPassword,
      confirmPassword,
    );

    if (isSuccess) {
      if (mounted) {
        showSnackBarMessage(context, 'Password changed successfully');
        Get.to(() => const ProfileScreen());
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, changePasswordController.errorMessage ?? 'Failed to change password', true);
      }
    }
  }

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}