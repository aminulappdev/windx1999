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
      Get.put(CreateWishListController());

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

  // Check if the Create Wishlist button should be enabled
  bool get _isCreateButtonEnabled =>
      descriptionCtrl.text.trim().isNotEmpty || selectedFile != null;

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
                const CustomAppBar(title: 'Set up your Wishlist'),
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
                        decoration: const InputDecoration(
                          hintText: 'Enter title your product',
                          errorStyle: TextStyle(
                              color: Color.fromARGB(255, 237, 82, 82)),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        // Validator is optional, so not required
                        validator: (value) => null,
                      ),
                      heightBox20,
                      Text(
                        'Description',
                        style: TextStyle(fontSize: 16.sp, color: Colors.white),
                      ),
                      heightBox10,
                      TextFormField(
                        controller: descriptionCtrl,
                        decoration: const InputDecoration(
                          hintText: 'Enter description of your product',
                          errorStyle: TextStyle(
                              color: Color.fromARGB(255, 237, 82, 82)),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        // Validator is optional, so not required
                        validator: (value) => null,
                        onChanged: (value) {
                          setState(() {}); // Update UI when text changes
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
                        decoration: const InputDecoration(
                          hintText: 'Enter product link',
                          errorStyle: TextStyle(
                              color: Color.fromARGB(255, 237, 82, 82)),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        // Validator is optional, so not required
                        validator: (value) => null,
                      ),
                      heightBox20,
                      Text(
                        'Product price',
                        style: TextStyle(fontSize: 16.sp, color: Colors.white),
                      ),
                      heightBox10,
                      TextFormField(
                        controller: priceCtrl,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.money),
                          hintText: 'Enter product price',
                          errorStyle: TextStyle(
                              color: Color.fromARGB(255, 237, 82, 82)),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        // Validator is optional, so not required
                        validator: (value) => null,
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
                GetBuilder<CreateWishListController>(
                  builder: (controller) {
                    return Opacity(
                      opacity: _isCreateButtonEnabled && !controller.inProgress
                          ? 1.0
                          : 0.3,
                      child: ElevatedButton(
                        onPressed: _isCreateButtonEnabled &&
                                !controller.inProgress
                            ? () {
                                createWishListFunction(
                                  StorageUtil.getData(StorageUtil.userId) ?? '',
                                  titleCtrl.text.trim(),
                                  descriptionCtrl.text.trim(),
                                  productUrlCtrl.text.trim(),
                                  priceCtrl.text,
                                  contentFile: selectedFile,
                                );
                              }
                            : null,
                        child: controller.inProgress
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                'Create wishlist',
                                style: TextStyle(
                                  color: _isCreateButtonEnabled
                                      ? Colors.white
                                      : Colors.grey,
                                ),
                              ),
                      ),
                    );
                  },
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
    if (authorId.isEmpty) {
      showSnackBarMessage(context, 'User ID is missing', true);
      return;
    }
    if (price.isNotEmpty) {
      try {
        int.parse(price);
      } catch (e) {
        showSnackBarMessage(context, 'Invalid price format', true);
        return;
      }
    }
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
        // Clear form after successful creation
        setState(() {
          titleCtrl.clear();
          descriptionCtrl.clear();
          productUrlCtrl.clear();
          priceCtrl.clear();
          selectedFile = null;
        });
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
            context,
            createWishListController.errorMessage ??
                'Failed to create wishlist',
            true);
      }
    }
  }
}
