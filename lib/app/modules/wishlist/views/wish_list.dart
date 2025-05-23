import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:windx1999/app/modules/profile/controllers/image_picker.dart';
import 'package:windx1999/app/modules/profile/views/set_up/user_prefer_screen.dart';
import 'package:windx1999/app/modules/profile/widgets/file_picker_browse.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/common_widgets/transparent_rectange_button.dart';
import 'package:windx1999/app/res/common_widgets/custom_app_bar.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  File? image;

  final ImagePickerHelper _imagePickerHelper = ImagePickerHelper();
  final TextEditingController titleCtrl = TextEditingController();
  final TextEditingController descriptionCtrl = TextEditingController();
  final TextEditingController productUrlCtrl = TextEditingController();
  final TextEditingController priceCtrl = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                heightBox20,
                CustomAppBar(title: 'Set up your Wishlist'),
                heightBox20,
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Title',
                        style: TextStyle(fontSize: 16.sp, color: Colors.white),
                      ),
                      heightBox10,
                      TextFormField(
                        controller: titleCtrl,
                        decoration: InputDecoration(
                          hintText: 'Enter title your product',
                          errorStyle: TextStyle(
                              color: const Color.fromARGB(255, 237, 82, 82)),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.emailAddress,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Enter title';
                          }
                          return null;
                        },
                      ),
                      heightBox20,
                      Text(
                        'Descrption',
                        style: TextStyle(fontSize: 16.sp, color: Colors.white),
                      ),
                      heightBox10,
                      TextFormField(
                        controller: descriptionCtrl,
                        decoration: InputDecoration(
                          hintText: 'Enter description your product',
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
                        'Product link',
                        style: TextStyle(fontSize: 16.sp, color: Colors.white),
                      ),
                      heightBox10,
                      TextFormField(
                        controller: productUrlCtrl,
                        decoration: InputDecoration(
                          hintText: 'Enter product link',
                          errorStyle: TextStyle(
                              color: const Color.fromARGB(255, 237, 82, 82)),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.emailAddress,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Enter product link';
                          }
                          return null;
                        },
                      ),
                      heightBox20,
                      Text(
                        'Product price',
                        style: TextStyle(fontSize: 16.sp, color: Colors.white),
                      ),
                      heightBox10,
                      TextFormField(
                        controller: priceCtrl,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.money),
                          hintText: 'Enter product price',
                          errorStyle: TextStyle(
                              color: const Color.fromARGB(255, 237, 82, 82)),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.emailAddress,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Enter product link';
                          }
                          return null;
                        },
                      ),
                      heightBox20,
                      Text(
                        'Upload image or video',
                        style: TextStyle(fontSize: 16.sp, color: Colors.white),
                      ),
                      heightBox10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FilePickerBrowse(
                            icon: Icons.photo,
                            mediaName: 'Upload your image',
                            ontap: () {
                              _imagePickerHelper.showAlertDialog(context,
                                  (File pickedImage) {
                                setState(() {
                                  image = pickedImage;
                                });
                              });
                            },
                          ),
                          FilePickerBrowse(
                            icon: Icons.photo,
                            mediaName: 'Upload your image',
                            ontap: () {},
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                heightBox24,
                ElevatedButton(
                  onPressed: () {
                    Get.to(UserPreferencesScreen());
                  },
                  child: Text('Confirm'),
                ),
                heightBox12,
                TransparentRectangleButton(
                  ontap: () {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
