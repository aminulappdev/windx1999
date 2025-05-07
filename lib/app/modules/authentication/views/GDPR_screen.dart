import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:windx1999/app/modules/authentication/controllers/create_user_controller.dart';
import 'package:windx1999/app/modules/authentication/views/email_verification_screen.dart';
import 'package:windx1999/app/modules/authentication/views/two_factor_screen.dart';
import 'package:windx1999/app/modules/authentication/widgets/condition_checkbox.dart';
import 'package:windx1999/app/res/common_widgets/custom_app_bar.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/common_widgets/custom_rectangle_buttom.dart';
import 'package:windx1999/app/res/common_widgets/custom_snackbar.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class GDPRConsentScreen extends StatefulWidget {
  const GDPRConsentScreen(
      {super.key,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.password,
      required this.confirmPassword});
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String confirmPassword;

  @override
  State<GDPRConsentScreen> createState() => _GDPRConsentScreenState();
}

class _GDPRConsentScreenState extends State<GDPRConsentScreen> {
  final CreateUserController createUserController = CreateUserController();

  bool isChecked01 = false;
  bool isChecked02 = false;
  bool isChecked03 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                heightBox20,
                CustomAppBar(title: 'GDPR Consent'),
                heightBox40,
                Text(
                  'Your Privacy Matters',
                  style: TextStyle(fontSize: 18.sp, color: Colors.white),
                ),
                heightBox4,
                Text(
                  'We value your privacy and ensure that your data is protected. We use your information to enhance your experience, improve app functionality, and provide personalized content. \n\nPlease review and manage your preferences below:',
                  style: TextStyle(fontSize: 16.sp, color: Colors.white),
                  textAlign: TextAlign.justify,
                ),
                heightBox12,
                ConditionCheckerCheckbox(
                  text:
                      'I consent to data processing for personalized experience',
                  isChecked: isChecked01,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked01 = value!;
                    });
                  },
                ),
                ConditionCheckerCheckbox(
                  text:
                      'I allow my data to be used for analytics and improvements',
                  isChecked: isChecked02,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked02 = value!;
                    });
                  },
                ),
                ConditionCheckerCheckbox(
                  text: 'I agree to the Terms & Conditions',
                  isChecked: isChecked03,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked03 = value!;
                    });
                  },
                ),
                heightBox14,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomRectangleButton(
                      text: 'Decline',
                      height: 48,
                      width: 152,
                      bgColor: Colors.transparent,
                      radiusSize: 50,
                      textColor: Colors.white,
                      ontap: () {},
                    ),
                    widthBox40,
                    CustomRectangleButton(
                      text: 'Accept',
                      height: 48,
                      width: 152,
                      bgColor: Color(0xff6CC7FE),
                      radiusSize: 50,
                      ontap: () {
                        print('Register information ........................');
                        print(widget.firstName);
                        signUpnBTN(
                            widget.firstName,
                            widget.lastName,
                            widget.email,
                            widget.password,
                            widget.confirmPassword);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signUpnBTN(String fName, String lName, String email,
      String password, String cPassword) async {
    final bool isSuccess = await createUserController.createUser(
        fName, lName, email, password, cPassword);

    if (isSuccess) {
      if (mounted) {
        var token = createUserController.userData?.otpToken?.token;
        print('Otp token F:  $token');
        showSnackBarMessage(context, 'Register successfully done');
        Get.to(EmailVerificationScreen(
          accessToken: token ?? 'Empty token',
        ));
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, createUserController.errorMessage ?? 'Login failed', true);
      }
    }
  }
}
