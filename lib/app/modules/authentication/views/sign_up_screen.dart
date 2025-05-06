import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:windx1999/app/modules/authentication/views/GDPR_screen.dart';
import 'package:windx1999/app/modules/authentication/widgets/auth_footer.dart';
import 'package:windx1999/app/modules/authentication/widgets/continue_with_button.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/common_widgets/liner_widget.dart';
import 'package:windx1999/app/res/app_images/assets_path.dart';
import 'package:windx1999/app/res/common_widgets/custom_app_bar.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _obscureText = true;
  bool _obscureConfirmText = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameCtrl = TextEditingController();
  final TextEditingController lastNameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController confirmPasswordCtrl = TextEditingController();

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
                CustomAppBar(title: 'Create Account'),
                heightBox40,
                SvgPicture.asset(
                  AssetsPath.updateMainLogo,
                  height: 120.h,
                  width: 155.w,
                ),
                heightBox16,
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 170.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'First name',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                                heightBox10,
                                TextFormField(
                                  controller: firstNameCtrl,
                                  decoration: InputDecoration(
                                    hintText: 'First name',
                                    errorStyle: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 237, 82, 82)),
                                  ),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'Enter first name';
                                    }

                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 170.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Last name',
                                  style: TextStyle(
                                      fontSize: 16.sp, color: Colors.white),
                                ),
                                heightBox10,
                                TextFormField(
                                  controller: lastNameCtrl,
                                  decoration: InputDecoration(
                                    hintText: 'Last name',
                                    errorStyle: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 237, 82, 82)),
                                  ),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'Enter last name';
                                    }

                                    return null;
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      heightBox24,
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
                heightBox30,
                ElevatedButton(
                    onPressed: () {
                      Get.to(GDPRConsentScreen(
                        firstName: firstNameCtrl.text,
                        lastName: lastNameCtrl.text,
                        email: emailCtrl.text,
                        password: passwordCtrl.text,
                        confirmPassword: confirmPasswordCtrl.text,
                      ));
                    },
                    child: Text('Sign Up')),
                heightBox12,
                Liner(
                  text: 'Or continue with',
                ),
                heightBox12,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ContinueElevatedButton(
                      logoPath: AssetsPath.googleLogo,
                      ontap: () {},
                    ),
                  ],
                ),
                heightBox20,
                AuthenticationFooterSection(
                  fTextName: 'Don’t have an account? ',
                  fTextColor: Color.fromARGB(255, 255, 255, 255),
                  sTextName: 'Sign in',
                  sTextColor: Color(0xff6CC7FE),
                  ontap: () {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
