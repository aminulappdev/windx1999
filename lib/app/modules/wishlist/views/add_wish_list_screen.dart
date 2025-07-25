// CreateWishlistScreen.dart
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:windx1999/app/modules/profile/controllers/content_controller.dart';
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
  final ContentController contentController = Get.put(ContentController());
  final CreateWishListController createWishListController =
      Get.put(CreateWishListController());
  bool isLoading = true; // Track loading state

  @override
  void initState() {
    super.initState();
    _loadContent(); // Load content and update state
    priceCtrl.addListener(() {
      setState(() {}); // Update UI when price changes
    });
  }

  Future<void> _loadContent() async {
    await contentController.getContent();
    setState(() {
      isLoading = false; // Update state when content is loaded
    });
  }

  @override
  void dispose() {
    titleCtrl.dispose();
    descriptionCtrl.dispose();
    productUrlCtrl.dispose();
    priceCtrl.dispose();
    super.dispose();
  }

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

  // Calculate total tokens based on price and totalToken from contentController
  String getTotalTokens() {
    if (contentController.contentlist == null ||
        contentController.contentlist!.isEmpty) {
      return '0'; // Return whole number as string
    }
    final dynamic tokenPrice = contentController.contentlist![0].tokenPrice;
    final double price = double.tryParse(priceCtrl.text.trim()) ?? 0.0;
    if (tokenPrice is num && tokenPrice > 0) {
      return (tokenPrice * price).round().toString(); // Round to whole number
    }
    return '0'; // Fallback if tokenPrice is invalid
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          )
        : Scaffold(
            body: CustomBackground(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
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
                              style:
                                  TextStyle(fontSize: 16.sp, color: Colors.white),
                            ),
                            heightBox10,
                            TextFormField(
                              controller: titleCtrl,
                              decoration: const InputDecoration(
                                hintText: 'Enter title your product',
                                errorStyle: TextStyle(
                                    color: Color.fromARGB(255, 237, 82, 82)),
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) => null,
                            ),
                            heightBox20,
                            Text(
                              'Description',
                              style:
                                  TextStyle(fontSize: 16.sp, color: Colors.white),
                            ),
                            heightBox10,
                            TextFormField(
                              controller: descriptionCtrl,
                              decoration: const InputDecoration(
                                hintText: 'Enter description of your product',
                                errorStyle: TextStyle(
                                    color: Color.fromARGB(255, 237, 82, 82)),
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) => null,
                              onChanged: (value) {
                                setState(() {}); // Update UI when text changes
                              },
                            ),
                            heightBox20,
                            Text(
                              'Product link',
                              style:
                                  TextStyle(fontSize: 16.sp, color: Colors.white),
                            ),
                            heightBox10,
                            TextFormField(
                              controller: productUrlCtrl,
                              decoration: const InputDecoration(
                                hintText: 'Enter product link',
                                errorStyle: TextStyle(
                                    color: Color.fromARGB(255, 237, 82, 82)),
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) => null,
                            ),
                            heightBox20,
                            Text(
                              'Product price',
                              style:
                                  TextStyle(fontSize: 16.sp, color: Colors.white),
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
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return null; // Price is optional
                                }
                                if (double.tryParse(value) == null) {
                                  return 'Please enter a valid number';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number,
                            ),
                            heightBox20,
                            Text(
                              'Total Token',
                              style:
                                  TextStyle(fontSize: 16.sp, color: Colors.white),
                            ),
                            heightBox10,
                            TextField(
                              enabled: false,
                              controller:
                                  TextEditingController(text: getTotalTokens()),
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.money),
                                errorStyle: TextStyle(
                                    color: Color.fromARGB(255, 237, 82, 82)),
                              ),
                            ),
                            heightBox20,
                            Text(
                              'Upload image or video',
                              style:
                                  TextStyle(fontSize: 16.sp, color: Colors.white),
                            ),
                            heightBox10,
                            Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    width:
                                        selectedFile != null ? 200.w : 150.w,
                                    height:
                                        selectedFile != null ? 80.h : 80.h,
                                    child: FilePickerBrowse(
                                      icon: Icons.upload_file,
                                      mediaName: 'Browse',
                                      ontap: pickFile,
                                    ),
                                  ),
                                  heightBox12,
                                  selectedFile != null
                                      ? Container(
                                          width: 250.w,
                                          height: 200.h,
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(12.r),
                                          ),
                                          child: selectedFile!.extension ==
                                                      'mp4' ||
                                                  selectedFile!.extension ==
                                                      'mov'
                                              ? const Icon(
                                                  Icons.videocam,
                                                  size: 50,
                                                  color: Colors.white,
                                                )
                                              : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.r),
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
                                      if (_formKey.currentState!.validate()) {
                                        createWishListFunction(
                                          StorageUtil.getData(
                                                  StorageUtil.userId) ??
                                              '',
                                          titleCtrl.text.trim(),
                                          descriptionCtrl.text.trim(),
                                          productUrlCtrl.text.trim(),
                                          priceCtrl.text,
                                          contentFile: selectedFile,
                                        );
                                      }
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
        double.parse(price);
      } catch (e) {
        showSnackBarMessage(context, 'Invalid price format', true);
        return;
      }
    }
    final String totalTokensStr = getTotalTokens();
    final int? totalTokens = int.tryParse(totalTokensStr);
    if (totalTokens == null) {
      showSnackBarMessage(context, 'Invalid total tokens calculation', true);
      return;
    }

    final bool isSuccess = await createWishListController.createWishList(
      authorId,
      title,
      description,
      link,
      price,
      totalTokens,
      contentFile: contentFile,
    );

    if (isSuccess) {
      if (mounted) {
        showSnackBarMessage(context, 'WishList created');
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