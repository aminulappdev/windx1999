import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windx1999/app/modules/profile/controllers/image_picker.dart';
import 'package:windx1999/app/res/app_images/assets_path.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String? selectedGender;
  File? image;
  final ImagePickerHelper _imagePickerHelper = ImagePickerHelper();
  bool showProductList = false;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 200,
                width: width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(AssetsPath.blackGirl),
                        fit: BoxFit.fill)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: CircleAvatar(
                            backgroundColor:
                                const Color.fromARGB(133, 255, 255, 255),
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            )),
                      ),
                      InkWell(
                        onTap: () {},
                        child: CircleAvatar(
                            backgroundColor:
                                const Color.fromARGB(133, 255, 255, 255),
                            child: Icon(
                              Icons.settings,
                              color: Colors.white,
                            )),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: -40,
                left: 150,
                child: Container(
                  height: 82.h,
                  width: 82.w,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white)),
                  child: CircleAvatar(
                    backgroundImage: AssetImage(AssetsPath.fbLogo),
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
                  bottom: -40,
                  left: 200,
                  child: AbsorbPointer(
                    absorbing: true,
                    child: InkWell(
                      onTap: () {
                        _imagePickerHelper.showAlertDialog(context,
                            (File pickedImage) {
                          setState(() {
                            image = pickedImage;
                          });
                        });
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            shape: BoxShape.circle,
                            color: const Color.fromARGB(146, 255, 255, 255)),
                        child: Center(
                          child: Icon(
                            Icons.camera,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ))
            ],
          ),
          heightBox50,
          Padding(
            padding: const EdgeInsets.all(16.0),
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
                          'Im Aminul. I have 2+ years of experience specializing in App development',
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
            child: ElevatedButton(onPressed: () {}, child: Text('Update')),
          )
        ],
      ),
    ));
  }
}
