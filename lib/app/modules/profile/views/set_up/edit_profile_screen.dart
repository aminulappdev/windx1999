import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:windx1999/app/modules/profile/controllers/image_picker.dart';
import 'package:windx1999/app/modules/profile/controllers/profile_controller.dart';
import 'package:windx1999/app/modules/profile/controllers/profile_setup_controller.dart';
import 'package:windx1999/app/modules/profile/views/profile_screen.dart';
import 'package:windx1999/app/res/app_images/assets_path.dart';
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
  final TextEditingController gendeCtrl = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final SetupProfileController setupProfileController =
      SetupProfileController();
  final ProfileController profileController = Get.put(ProfileController());

  bool showProductList = false;

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
        });
      }
    });
  }

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
                          image: banner != null
                              ? FileImage(banner!)
                              : NetworkImage(profileController
                                      .profileData?.banner ??
                                  'https://fastly.picsum.photos/id/229/200/300.jpg?hmac=WD1_MXzGKrVpaJj2Utxv7FoijRJ6h4S4zrBj7wmsx1U'),
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
                            border: Border.all(color: Colors.white)),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(profileController
                                  .profileData?.photoUrl ??
                              'https://fastly.picsum.photos/id/229/200/300.jpg?hmac=WD1_MXzGKrVpaJj2Utxv7FoijRJ6h4S4zrBj7wmsx1U'),
                          radius: 40.r,
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
                    ),
                    Positioned(
                      bottom: 20.h,
                      left: (width / 2) - (82.w / 2),
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
                                  image = pickedImage;
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
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name',
                          style:
                              TextStyle(fontSize: 16.sp, color: Colors.white),
                        ),
                        heightBox10,
                        TextFormField(
                          controller: nameCtrl,
                          decoration: InputDecoration(
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
                          style:
                              TextStyle(fontSize: 16.sp, color: Colors.white),
                        ),
                        heightBox10,
                        TextFormField(
                          enabled: false,
                          controller: usernameCtrl,
                          decoration: InputDecoration(
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
                          style:
                              TextStyle(fontSize: 16.sp, color: Colors.white),
                        ),
                        heightBox10,
                        TextFormField(
                          controller: bioCtrl,
                          decoration: InputDecoration(
                            hintText: 'Enter your bio',
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
                          style:
                              TextStyle(fontSize: 16.sp, color: Colors.white),
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
                ),
                heightBox12,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ElevatedButton(
                    onPressed: () {
                      onTapToNextButton();
                    },
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

  Future<void> onTapToNextButton() async {
    if (_formKey.currentState!.validate()) {
      final bool isSuccess = await setupProfileController.updateProfile(
          nameCtrl.text,
          usernameCtrl.text,
          bioCtrl.text,
          selectedGender ?? 'male',
          image,
          banner: banner);

      if (isSuccess) {
        if (mounted) {
          profileController.getMyProfile();
          showSnackBarMessage(context, 'Profile updated');
          Get.to(ProfileScreen());
          
        } else {
          if (mounted) {
            showSnackBarMessage(
                context, setupProfileController.errorMessage!, true);
          }
        }
      } else {
        if (mounted) {
          // print('Error show ----------------------------------');
          showSnackBarMessage(
              context, setupProfileController.errorMessage!, true);
        }
      }
    }
  }
}
