import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:windx1999/app/modules/authentication/controllers/create_user_controller.dart';
import 'package:windx1999/app/modules/authentication/views/email_verification_screen.dart';
import 'package:windx1999/app/modules/authentication/widgets/condition_checkbox.dart';
import 'package:windx1999/app/res/common_widgets/custom_app_bar.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/common_widgets/custom_rectangle_buttom.dart';
import 'package:windx1999/app/res/common_widgets/custom_snackbar.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class GDPRConsentScreen extends StatefulWidget {
  const GDPRConsentScreen({
    super.key,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.name,
  });
  final String name;
  final String email;
  final String password;
  final String confirmPassword;

  @override
  State<GDPRConsentScreen> createState() => _GDPRConsentScreenState();
}

class _GDPRConsentScreenState extends State<GDPRConsentScreen> {
  final CreateUserController createUserController = Get.put(CreateUserController());

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
                  text: 'I consent to data processing for personalized experience',
                  isChecked: isChecked01,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked01 = value!;
                    });
                  },
                ),
                ConditionCheckerCheckbox(
                  text: 'I allow my data to be used for analytics and improvements',
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
                GetBuilder<CreateUserController>(
                  builder: (controller) {
                    return CustomRectangleButton(
                      text: controller.inProgress ? '' : 'Accept',
                      height: 48,
                      width: MediaQuery.of(context).size.width,
                      bgColor: isChecked01 && isChecked02 && isChecked03
                          ? const Color(0xff6CC7FE)
                          : const Color.fromARGB(178, 108, 198, 254),
                      radiusSize: 50,
                      ontap: isChecked01 && isChecked02 && isChecked03 && !controller.inProgress
                          ? () {
                              signUpnBTN(
                                widget.name,
                                widget.email,
                                widget.password,
                                widget.confirmPassword,
                              );
                            }
                          : () {
                              print('Register information ........................');
                              print(widget.name);
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
                          : null,
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

  Future<void> signUpnBTN(String name, String email, String password, String cPassword) async {
    final bool isSuccess = await createUserController.createUser(name, email, password, cPassword);

    if (isSuccess) {
      if (mounted) {
        var token = createUserController.userData?.otpToken?.token;
        print('Otp token F: $token');
        showSnackBarMessage(context, 'Register successfully done');
        Get.to(() => EmailVerificationScreen(
              email: email,
              accessToken: token ?? 'Empty token',
            ));
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, createUserController.errorMessage ?? 'Registration failed', true);
      }
    }
  }
}