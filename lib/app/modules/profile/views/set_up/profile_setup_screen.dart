import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:windx1999/app/modules/profile/controllers/image_picker.dart';
import 'package:windx1999/app/modules/profile/views/set_up/address_screen.dart';
import 'package:windx1999/app/res/app_images/assets_path.dart';
import 'package:windx1999/app/res/common_widgets/custom_app_bar.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';


class ProfileSetupScreen extends StatefulWidget {
  final String userId;
  const ProfileSetupScreen({super.key, required this.userId});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  String? selectedGender;
  File? image;

  final ImagePickerHelper _imagePickerHelper = ImagePickerHelper();
  

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
                  CustomAppBar(title: 'Profile Set-up'),
                  heightBox40,
                  Stack(
                    children: [
                      Container(
                        height: 102.h,
                        width: 102.w,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white)),
                        child: CircleAvatar(
                          backgroundImage: AssetImage(AssetsPath.fbLogo),
                          radius: 50.r,
                          child: image != null
                              ? ClipOval(
                                  child: Image.file(
                                    image!,
                                    width: 100.w,
                                    height: 100.h,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Container(),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          backgroundColor: Color(0xff9C57FF),
                          child: GestureDetector(
                            onTap: () {
                              _imagePickerHelper.showAlertDialog(context, (File pickedImage) {
                                setState(() {
                                  image = pickedImage;
                                });
                              });
                            },
                            child: Center(
                              child: Icon(
                                Icons.camera,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  heightBox30,
                  Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name',
                          style: TextStyle(fontSize: 16.sp, color: Colors.white),
                        ),
                        heightBox10,
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Enter your name',
                            errorStyle: TextStyle(
                                color: const Color.fromARGB(255, 237, 82, 82)),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.emailAddress,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Enter name';
                            }
                            return null;
                          },
                        ),
                        heightBox20,
                        Text(
                          'Enter your username',
                          style: TextStyle(fontSize: 16.sp, color: Colors.white),
                        ),
                        heightBox10,
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'aminulappdev',
                            errorStyle: TextStyle(
                                color: const Color.fromARGB(255, 237, 82, 82)),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.emailAddress,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Enter username';
                            }
                            return null;
                          },
                        ),
                        heightBox20,
                        Text(
                          'Bio',
                          style: TextStyle(fontSize: 16.sp, color: Colors.white),
                        ),
                        heightBox10,
                        TextFormField(
                          decoration: InputDecoration(
                            hintText:
                                'Enter your bio',
                            errorStyle: TextStyle(
                                color: const Color.fromARGB(255, 237, 82, 82)),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.emailAddress,
                          maxLines: 2,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Enter bio';
                            }
                            return null;
                          },
                        ),
                        heightBox20,
                        Text(
                          'Gender',
                          style: TextStyle(fontSize: 16.sp, color: Colors.white),
                        ),
                        heightBox10,
                        DropdownButtonFormField<String>(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Enter gender';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Gander',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          value: selectedGender,
                          items: ["Male", "Female"].map((String gender) {
                            return DropdownMenuItem(
                              value: gender,
                              child: Text(
                                gender,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14.sp),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedGender = newValue;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  heightBox24,
                  ElevatedButton(
                      onPressed: () {
                        Get.to(AddressScreen());
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
