import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:windx1999/app/modules/authentication/views/forgot_password_screen.dart';
import 'package:windx1999/app/modules/authentication/views/sign_up_screen.dart';
import 'package:windx1999/app/modules/authentication/widgets/auth_footer.dart';
import 'package:windx1999/app/modules/authentication/widgets/continue_with_button.dart';
import 'package:windx1999/app/modules/authentication/widgets/forgot_password.dart';
import 'package:windx1999/app/res/common_widgets/liner_widget.dart';
import 'package:windx1999/app/modules/profile/views/profile_setup_screen.dart';
import 'package:windx1999/app/res/app_images/assets_path.dart';
import 'package:windx1999/app/res/common_widgets/custom_app_bar.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomAppBar(title: 'Log in'),
                heightBox40,
                SvgPicture.asset(
                  AssetsPath.mainLogo,
                  height: 120.h,
                  width: 155.w,
                ),
                heightBox16,
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
                          if (EmailValidator.validate(value) == false) {
                            return 'Enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      heightBox24,
                      Text(
                        'Password',
                        style: TextStyle(fontSize: 16.sp, color: Colors.white),
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
                    ],
                  ),
                ),
                heightBox12,
                ForgotPasswordRow(ontap: () {
                  Get.to(ForgotpasswordScreen());
                }),
                heightBox12,
                ElevatedButton(onPressed: () {
                   Get.to(ProfileSetupScreen());
                }, child: Text('Log In')),
                heightBox12,
                Liner(text: 'Or continue with',),
                heightBox12,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ContinueElevatedButton(
                      logoPath: AssetsPath.googleLogo,
                    ),
                    widthBox8,
                    ContinueElevatedButton(
                      logoPath: AssetsPath.fbLogo,
                    ),
                  ],
                ),
                heightBox20,
                AuthenticationFooterSection(
                  fTextName: 'Don’t have an account? ',
                  fTextColor: Color.fromARGB(255, 255, 255, 255),
                  sTextName: 'Sign up',
                  sTextColor: Color(0xff6CC7FE),
                  ontap: () {
                     Get.to(SignUpScreen());
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
