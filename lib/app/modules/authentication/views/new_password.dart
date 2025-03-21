import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:windx1999/app/res/app_images/assets_path.dart';
import 'package:windx1999/app/res/common_widgets/custom_app_bar.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() =>
      _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {

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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                      ],
                    ),
                  ),
                 
                  heightBox24,
                  ElevatedButton(onPressed: () {}, child: Text('Save'))
                ],
              ),
            ),
          ),
        ),
      
    );
  }
}
