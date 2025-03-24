import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:windx1999/app/modules/profile/controllers/image_picker.dart';
import 'package:windx1999/app/res/app_images/assets_path.dart';
import 'package:windx1999/app/res/common_widgets/circle_aveture_icon.dart';
import 'package:windx1999/app/res/common_widgets/container_circle_icon.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String? selectedGender;
  File? profileImage;
  File? coverImage;
  final ImagePickerHelper _imagePickerHelper = ImagePickerHelper();
  bool showProductList = false;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
          body: CustomBackground(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: 200.h,
                        width: width,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: coverImage != null
                                ? FileImage(coverImage!)
                                : AssetImage(AssetsPath.blackGirl),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvetareIconWidget(
                                iconData: Icons.arrow_back,
                                bgColor: Color.fromARGB(133, 255, 255, 255),
                                iconColor: Colors.white,
                                ontap: () {
                                  Get.back();
                                },
                              ),
                              CircleAvetareIconWidget(
                                iconData: Icons.photo_camera,
                                bgColor: Color.fromARGB(133, 255, 255, 255),
                                iconColor: Colors.white,
                                ontap: () {
                                  _imagePickerHelper.showAlertDialog(context,
                                      (File pickedImage) {
                                    setState(() {
                                      coverImage = pickedImage;
                                    });
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -40.h,
                       left: (width / 2) - (82.w / 2),
                        child: Container(
                          height: 82.h,
                          width: 82.w,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white)),
                          child: CircleAvatar(
                            backgroundImage: AssetImage(AssetsPath.fbLogo),
                            radius: 40.r,
                            child: profileImage != null
                                ? ClipOval(
                                    child: Image.file(
                                      profileImage!,
                                      width: 100.w,
                                      height: 100.h,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Container(),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 20.h,
                        left: (width / 2) - (82.w / 2) , 
                        child: ContainerCircleIcon(
                          iconData: Icons.edit,
                          bgColor: Color.fromARGB(146, 255, 255, 255),
                          borderColor: Colors.white,
                          containerSize: 30,
                          iconColor: Colors.white,
                          ontap: () {
                            _imagePickerHelper.showAlertDialog(
                              context,
                              (File pickedImage) {
                                setState(
                                  () {
                                    profileImage = pickedImage;
                                  },
                                );
                              },
                            );
                          },
                        ),
                      )
                    ],
                  ),
                  heightBox50,
                  Padding(
                    padding: EdgeInsets.all(16.0.h),
                    child: Form(
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
                              hintText: 'Md Aminul Islam',
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
                            'Username',
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
                                  style:
                                      TextStyle(color: Colors.black, fontSize: 14.sp),
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
                  ),
                  heightBox12,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        
      ),
    );
  }
}
