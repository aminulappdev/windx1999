import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:windx1999/app/modules/profile/views/set_up/wish_list.dart';
import 'package:windx1999/app/res/app_images/assets_path.dart';
import 'package:windx1999/app/res/common_widgets/custom_app_bar.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
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
                  CustomAppBar(title: 'Set up your Adress'),
                  heightBox40,
                  SvgPicture.asset(
                    AssetsPath.address,
                    height: 228.h,
                    width: 305.w,
                  ),
                  heightBox40,
                  Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Country name',
                          style: TextStyle(fontSize: 16.sp, color: Colors.white),
                        ),
                        heightBox10,
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Enter country name',
                            errorStyle: TextStyle(
                                color: const Color.fromARGB(255, 237, 82, 82)),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.emailAddress,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Enter country name';
                            }
                            return null;
                          },
                        ),
                        heightBox20,
                        Text(
                          'Street Address',
                          style: TextStyle(fontSize: 16.sp, color: Colors.white),
                        ),
                        heightBox10,
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Enter your address',
                            errorStyle: TextStyle(
                                color: const Color.fromARGB(255, 237, 82, 82)),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.emailAddress,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Enter address';
                            }
                            return null;
                          },
                        ),
                        heightBox20,
                        Text(
                          'City',
                          style: TextStyle(fontSize: 16.sp, color: Colors.white),
                        ),
                        heightBox10,
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Enter your city',
                            errorStyle: TextStyle(
                                color: const Color.fromARGB(255, 237, 82, 82)),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.emailAddress,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Enter city';
                            }
                            return null;
                          },
                        ),
                        heightBox20,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 170.w,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'State',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                  heightBox10,
                                  TextFormField(
                                    decoration: InputDecoration(
                                      hintText: 'Enter your state',
                                      errorStyle: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 237, 82, 82)),
                                    ),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'Enter state';
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
                                    'Zip Code',
                                    style: TextStyle(
                                        fontSize: 16.sp, color: Colors.white),
                                  ),
                                  heightBox10,
                                  TextFormField(
                                    decoration: InputDecoration(
                                      hintText: 'Enter your zip code',
                                      errorStyle: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 237, 82, 82)),
                                    ),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'Enter zip code';
                                      }
          
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  heightBox24,
                  ElevatedButton(
                      onPressed: () {
                        Get.to(WishlistScreen());
                      },
                      child: Text('Continue'))
                ],
              ),
            ),
          ),
        ),
      
    );
  }
}
