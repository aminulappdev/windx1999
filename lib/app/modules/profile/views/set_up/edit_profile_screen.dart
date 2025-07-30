
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:windx1999/app/modules/profile/controllers/image_picker.dart';
import 'package:windx1999/app/modules/profile/controllers/profile_controller.dart';
import 'package:windx1999/app/modules/profile/controllers/profile_setup_controller.dart';
import 'package:windx1999/app/res/common_widgets/circle_aveture_icon.dart';
import 'package:windx1999/app/res/common_widgets/container_circle_icon.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/common_widgets/custom_snackbar.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String? selectedGender;
  File? image;
  File? banner;
  final ImagePickerHelper _imagePickerHelper = ImagePickerHelper();
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController usernameCtrl = TextEditingController();
  final TextEditingController bioCtrl = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final SetupProfileController setupProfileController =
      Get.put(SetupProfileController());
  final ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    // Defer profile fetching to avoid setState during build
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await profileController.getMyProfile();
      if (mounted) {
        setState(() {
          nameCtrl.text = profileController.profileData?.name ?? '';
          usernameCtrl.text = profileController.profileData?.username ?? '';
          bioCtrl.text = profileController.profileData?.bio ?? '';
          // Set selectedGender from API response
          selectedGender = profileController.profileData?.gender ?? 'Male'; // Default to 'Male' if null
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
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
                        image: banner != null
                            ? FileImage(banner!)
                            : NetworkImage(
                                profileController.profileData?.banner ??
                                    'https://fastly.picsum.photos/id/229/200/300.jpg?hmac=WD1_MXzGKrVpaJj2Utxv7FoijRJ6h4S4zrBj7wmsx1U',
                              ) as ImageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 40, horizontal: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvetareIconWidget(
                            iconData: Icons.arrow_back,
                            bgColor: const Color.fromARGB(133, 255, 255, 255),
                            iconColor: Colors.white,
                            ontap: () {
                              Get.back();
                            },
                          ),
                          CircleAvetareIconWidget(
                            iconData: Icons.photo_camera,
                            bgColor: const Color.fromARGB(133, 255, 255, 255),
                            iconColor: Colors.white,
                            ontap: () {
                              _imagePickerHelper.showAlertDialog(context,
                                  (File pickedImage) {
                                setState(() {
                                  banner = pickedImage;
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
                        border: Border.all(color: Colors.white),
                      ),
                      child: CircleAvatar(
                        backgroundImage: image != null
                            ? FileImage(image!) as ImageProvider
                            : NetworkImage(
                                profileController.profileData?.photoUrl ??
                                    'https://fastly.picsum.photos/id/229/200/300.jpg?hmac=WD1_MXzGKrVpaJj2Utxv7FoijRJ6h4S4zrBj7wmsx1U',
                              ) as ImageProvider,
                        radius: 40.r,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20.h,
                    left: (width / 2) - (82.w / 2),
                    child: ContainerCircleIcon(
                      iconData: Icons.edit,
                      bgColor: const Color.fromARGB(146, 255, 255, 255),
                      borderColor: Colors.white,
                      containerSize: 30,
                      iconColor: Colors.white,
                      ontap: () {
                        _imagePickerHelper.showAlertDialog(context,
                            (File pickedImage) {
                          setState(() {
                            image = pickedImage;
                          });
                        });
                      },
                    ),
                  ),
                ],
              ),
              heightBox50,
              Padding(
                padding: EdgeInsets.all(16.0.h),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name',
                        style: TextStyle(fontSize: 16.sp, color: Colors.white),
                      ),
                      heightBox10,
                      TextFormField(
                        maxLength: 30,
                        controller: nameCtrl,
                        decoration: const InputDecoration(
                          hintText: 'Enter your name',
                          errorStyle: TextStyle(
                              color: Color.fromARGB(255, 237, 82, 82)),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.name,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
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
                        maxLength: 20,
                        controller: usernameCtrl,
                        decoration: const InputDecoration(
                          hintText: 'Enter your username',
                          errorStyle: TextStyle(
                              color: Color.fromARGB(255, 237, 82, 82)),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.text,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
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
                        maxLength: 150,
                        controller: bioCtrl,
                        decoration: const InputDecoration(
                          hintText: 'Enter your bio',
                          errorStyle: TextStyle(
                              color: Color.fromARGB(255, 237, 82, 82)),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.multiline,
                        maxLines: 2,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
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
                          if (value == null || value.isEmpty) {
                            return 'Select gender';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Select gender',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
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
              ),
              heightBox12,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GetBuilder<SetupProfileController>(
                  id: 'update_profile',
                  builder: (controller) {
                    return ElevatedButton(
                      onPressed: controller.inProgress
                          ? null // Disable button during API call
                          : () async {
                              if (_formKey.currentState!.validate()) {
                                await onTapToNextButton();
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50.h), // Full-width button
                        backgroundColor: Colors.blue, // Adjust to match theme
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      child: controller.inProgress
                          ? SizedBox(
                              height: 24.h,
                              width: 24.h,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 3.w,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : Text(
                              'Update',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    );
                  },
                ),
              ),
              heightBox20,
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onTapToNextButton() async {
    if (_formKey.currentState!.validate()) {
      final bool isSuccess = await setupProfileController.updateProfile(
        nameCtrl.text,
        usernameCtrl.text,
        bioCtrl.text,
        selectedGender ?? 'Male',
        image,
        banner: banner,
      );

      if (isSuccess) {
        if (mounted) {
          await profileController.getMyProfile();
          // showSnackBarMessage(context, 'Profile updated successfully');
          Get.back();
        }
      } else {
        if (mounted) {
          showSnackBarMessage(
              context,
              setupProfileController.errorMessage ?? 'Failed to update profile',
              true);
        }
      }
    }
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    usernameCtrl.dispose();
    bioCtrl.dispose();
    super.dispose();
  }
}
