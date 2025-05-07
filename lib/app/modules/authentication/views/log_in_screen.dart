import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:windx1999/app/modules/authentication/controllers/log_in_controller.dart';
import 'package:windx1999/app/modules/authentication/views/forgot_password_screen.dart';
import 'package:windx1999/app/modules/authentication/views/sign_up_screen.dart';
import 'package:windx1999/app/modules/authentication/widgets/auth_footer.dart';
import 'package:windx1999/app/modules/authentication/widgets/continue_with_button.dart';
import 'package:windx1999/app/modules/authentication/widgets/forgot_password.dart';
import 'package:windx1999/app/modules/common/views/navigation_bar_screen.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/common_widgets/custom_snackbar.dart';
import 'package:windx1999/app/res/common_widgets/liner_widget.dart';
import 'package:windx1999/app/modules/profile/views/set_up/profile_setup_screen.dart';
import 'package:windx1999/app/res/app_images/assets_path.dart';
import 'package:windx1999/app/res/common_widgets/custom_app_bar.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final LogInController logInController = LogInController();

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                heightBox20,
                CustomAppBar(title: 'Log in'),
                heightBox20,
                SvgPicture.asset(
                  AssetsPath.updateMainLogo,
                  height: 160.h,
                  width: 195.w,
                ),
                heightBox8,
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
                        controller: passCtrl,
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
                ElevatedButton(
                    onPressed: () {
                      loginBTN(emailCtrl.text, passCtrl.text);
                    },
                    child: Text('Log In')),
                heightBox12,
                Liner(
                  text: 'Or continue with',
                ),
                heightBox12,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ContinueElevatedButton(
                      ontap: () {},
                      logoPath: AssetsPath.googleLogo,
                    ),
                    widthBox8,
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

  Future<void> loginBTN(String email, String password) async {
    final bool isSuccess = await logInController.loginUser(email, password);

    if (isSuccess) {
      if (mounted) {
        showSnackBarMessage(context, 'Login successfully done');
        Get.offAll(BottomNavBarScreen());
      }

    } else {
      if (mounted) {
        showSnackBarMessage(
            context, logInController.errorMessage ?? 'Login failed', true);
      }
    }
  }
}
