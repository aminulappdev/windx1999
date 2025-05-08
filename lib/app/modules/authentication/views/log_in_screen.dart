import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:windx1999/app/modules/authentication/controllers/log_in_controller.dart';
import 'package:windx1999/app/modules/authentication/controllers/resend_otp_controller.dart';
import 'package:windx1999/app/modules/authentication/views/email_verification_screen.dart';
import 'package:windx1999/app/modules/authentication/views/forgot_password_screen.dart';
import 'package:windx1999/app/modules/authentication/views/sign_up_screen.dart';
import 'package:windx1999/app/modules/authentication/widgets/auth_footer.dart';
import 'package:windx1999/app/modules/authentication/widgets/forgot_password.dart';
import 'package:windx1999/app/modules/common/views/navigation_bar_screen.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/common_widgets/custom_snackbar.dart';
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
  final LogInController logInController = Get.find<LogInController>();
  final ResendOtpController resendOtpController = ResendOtpController();

  bool _obscureText = true;
  bool isChecked = false;

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
                ForgotPasswordRow(
                  isChecked: isChecked,
                  onCheckedChanged: (val) {
                    setState(() {
                      isChecked = val;
                    });
                  },
                  ontap: () {
                    Get.to(ForgotpasswordScreen());
                  },
                ),
                heightBox12,
                isChecked == true
                    ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        onPressed: () {
                          loginBTN(emailCtrl.text, passCtrl.text);
                        },
                        child: Text('Log In'),
                      )
                    : Opacity(
                      opacity: 0.3,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                          onPressed: () {},
                          child: Text('Log In',style: TextStyle(color: Colors.grey),),
                        ),
                    ),
                heightBox20,
                AuthenticationFooterSection(
                  fTextName: 'Don’t have an account? ',
                  fTextColor: Colors.white,
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

    if(logInController.errorMessage?.contains('not') == true){
         print('User not verified otp');
          final bool isSuccess = await resendOtpController.resendOtp(email,);
          var token = resendOtpController.resendOtpData?.token ?? 'Empty';
          print('ResendOtp : $token');
          Get.to(EmailVerificationScreen(accessToken: token,));
    }
    else if (isSuccess) {
      print('User verified');
      if (mounted) {
        showSnackBarMessage(context, 'Login successfully done');
        Get.offAll(BottomNavBarScreen());
      }
    } else {
      print('User not verified');     
      if (mounted) {
        showSnackBarMessage(
            context, logInController.errorMessage ?? 'Login failed', true);
      }
    }
  }
}
