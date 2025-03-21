import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:windx1999/app/modules/authentication/views/forgot_password_screen.dart';
import 'package:windx1999/app/res/common_widgets/custom_app_bar.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class ChangedPasswordScreen extends StatefulWidget {
  const ChangedPasswordScreen({super.key});

  @override
  State<ChangedPasswordScreen> createState() => _ChangedPasswordScreenState();
}

class _ChangedPasswordScreenState extends State<ChangedPasswordScreen> {
  bool _obscureText = true;
  bool _obscureConfirmText = true;
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
                  CustomAppBar(title: 'Changed Password'),
                  heightBox40,
                  Text(
                    'Your password must be at least 6 characters and should include a combination of numbers, letters and special characters). ',
                    style: TextStyle(fontSize: 16.sp, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  heightBox30,
                  Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Current Password',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        heightBox10,
                        TextFormField(
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
                          'Password',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        heightBox10,
                        TextFormField(
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
                        heightBox12,
                        GestureDetector(
                          onTap: () {
                            Get.to(ForgotpasswordScreen());
                          },
                          child: Text(
                            'Confirm password',
                            style:
                                TextStyle(fontSize: 16.sp, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  heightBox24,
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Change password',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      
    );
  }
}
