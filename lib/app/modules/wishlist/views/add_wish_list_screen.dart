import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:windx1999/app/modules/profile/views/set_up/user_prefer_screen.dart';
import 'package:windx1999/app/modules/profile/widgets/file_picker_browse.dart';
import 'package:windx1999/app/modules/wishlist/controller/create_wishList_controller.dart';
import 'package:windx1999/app/res/common_widgets/custom_app_bar.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/common_widgets/custom_snackbar.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';
import 'package:windx1999/get_storage.dart';

class CreateWishlistScreen extends StatefulWidget {
  const CreateWishlistScreen({super.key});

  @override
  State<CreateWishlistScreen> createState() => _CreateWishlistScreenState();
}

class _CreateWishlistScreenState extends State<CreateWishlistScreen> {
  PlatformFile? selectedFile;
  final TextEditingController titleCtrl = TextEditingController();
  final TextEditingController descriptionCtrl = TextEditingController();
  final TextEditingController productUrlCtrl = TextEditingController();
  final TextEditingController priceCtrl = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final CreateWishListController createWishListController =
      CreateWishListController();

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'mp4', 'mov'],
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        selectedFile = result.files.single;
      });
    }
  }

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
                        validator: (value) =>
                            value!.isEmpty ? 'Enter title' : null,
                      ),
                      heightBox20,
                      Text(
                        'Description',
                        style: TextStyle(fontSize: 16.sp, color: Colors.white),
                      ),
                      heightBox10,
                      TextFormField(
                        controller: descriptionCtrl,
                        decoration: InputDecoration(
                          hintText: 'Enter description of your product',
                          errorStyle: TextStyle(
                              color: const Color.fromARGB(255, 237, 82, 82)),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) =>
                            value!.isEmpty ? 'Enter description' : null,
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
                        validator: (value) =>
                            value!.isEmpty ? 'Enter product link' : null,
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
                          prefixIcon: const Icon(Icons.money),
                          hintText: 'Enter product price',
                          errorStyle: TextStyle(
                              color: const Color.fromARGB(255, 237, 82, 82)),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) =>
                            value!.isEmpty ? 'Enter product price' : null,
                      ),
                      heightBox20,
                      Text(
                        'Upload image or video',
                        style: TextStyle(fontSize: 16.sp, color: Colors.white),
                      ),
                      heightBox10,
                      Center(
                        child: Column(
                          children: [
                            // File picker button (always visible)
                            SizedBox(
                              width: selectedFile != null ? 200.w : 150.w,
                              height: selectedFile != null ? 80.h : 80.h,
                              child: FilePickerBrowse(
                                icon: Icons.upload_file,
                                mediaName: 'Browse',
                                ontap: pickFile,
                              ),
                            ),
                            heightBox12,
                            // Display selected file (image or video icon)
                            selectedFile != null
                                ? Container(
                                    width: 250.w,
                                    height: 200.h,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white),
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    child: selectedFile!.extension == 'mp4' ||
                                            selectedFile!.extension == 'mov'
                                        ? const Icon(
                                            Icons.videocam,
                                            size: 50,
                                            color: Colors.white,
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12.r),
                                            child: Image.file(
                                              File(selectedFile!.path!),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                heightBox24,
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      createWishListFunction(
                        StorageUtil.getData(StorageUtil.userId),
                        titleCtrl.text.trim(),
                        descriptionCtrl.text.trim(),
                        productUrlCtrl.text.trim(),
                        priceCtrl.text,
                        contentFile: selectedFile,
                      );
                    }
                  },
                  child: const Text('Create wishlist'),
                ),
                heightBox12,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> createWishListFunction(
    String authorId,
    String title,
    String description,
    String link,
    dynamic price, {
    PlatformFile? contentFile,
  }) async {
    if (_formKey.currentState!.validate()) {
      final bool isSuccess = await createWishListController.createWishList(
        authorId,
        title,
        description,
        link,
        price,
        contentFile: contentFile,
      );

      if (isSuccess) {
        if (mounted) {
          showSnackBarMessage(context, 'WishList created');
          
        }
      } else {
        if (mounted) {
          showSnackBarMessage(
              context, createWishListController.errorMessage!, true);
        }
      }
    }
  }
}
