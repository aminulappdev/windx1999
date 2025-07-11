// ignore_for_file: unused_field

import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:windx1999/app/modules/post/controller/create_post_controller.dart';
import 'package:windx1999/app/modules/post/views/post_audiences.dart';
import 'package:windx1999/app/modules/post/widgets/post_dropdown_widget.dart';
import 'package:windx1999/app/res/app_images/assets_path.dart';
import 'package:windx1999/app/res/common_widgets/custom_app_bar.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/common_widgets/custom_snackbar.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';
import 'package:windx1999/get_storage.dart';

class PostScreen extends StatefulWidget {
  final String audienceType;
  const PostScreen({super.key, required this.audienceType});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  PlatformFile? _selectedFile; // Only one selected file
  String? _selectedPostType = 'Feed'; // Initialize to match dropdown's initial value
  final TextEditingController _statusController = TextEditingController();
  final CreatePostController createPostController = CreatePostController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Pick single file with validation for Reels
  Future<void> _pickFile() async {
    if (_selectedPostType == null) {
      showSnackBarMessage(context, 'Please select a post type first', true);
      return;
    }

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: _selectedPostType == 'Feed'
          ? ['jpg', 'jpeg', 'png', 'mp4', 'mov']
          : ['mp4', 'mov'],
    );

    if (result != null && result.files.isNotEmpty) {
      final file = result.files.first;
      // Check if postType is Reels and file is not a video
      if (_selectedPostType == 'Reels' &&
          !(file.extension == 'mp4' || file.extension == 'mov')) {
        showSnackBarMessage(context, 'Only video files can be uploaded for Reels', true);
        return;
      }
      setState(() {
        _selectedFile = file;
      });
    }
  }

  void _onPostTypeChanged(String? value) {
    setState(() {
      _selectedPostType = value;
      // Clear selected file if post type changes to Reels and the current file is not a video
      if (_selectedFile != null && value == 'Reels' &&
          !(_selectedFile!.extension == 'mp4' || _selectedFile!.extension == 'mov')) {
        _selectedFile = null;
        showSnackBarMessage(context, 'Selected file removed. Please upload a video for Reels', true);
      }
    });
    if (value != null) {
      print('Selected post type: $value');
    }
  }

  @override
  void dispose() {
    _statusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        child: Padding(
          padding: EdgeInsets.all(16.0.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                heightBox20,
                CustomAppBar(
                  title: 'New post',
                  showButton: true,
                  ontap: () {
                    createPostFunction(
                        StorageUtil.getData(StorageUtil.userId),
                        _statusController.text,
                        widget.audienceType,
                        _selectedPostType!,
                        contentFile: _selectedFile);
                  },
                  color: Colors.white,
                  textColor: Colors.grey,
                ),
                heightBox20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(AssetsPath.blackGirl),
                        ),
                        widthBox5,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nammi Fatema',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                            heightBox4,
                            InkWell(
                              onTap: () {
                                Get.to(PostAudiencesScreen());
                              },
                              child: Container(
                                height: 24.h,
                                width: 80.w,
                                decoration: BoxDecoration(
                                  color: const Color(0xffEBF5FF),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.group, size: 14),
                                    widthBox4,
                                    Text(
                                      widget.audienceType,
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    CustomDropdown(
                      items: ['Reels', 'Feed'],
                      hintText: 'Select post type',
                      initialValue: 'Feed',
                      onChanged: _onPostTypeChanged,
                    ),
                  ],
                ),
                heightBox20,
                Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _statusController,
                    style: TextStyle(color: Colors.white),
                    maxLines: 4,
                    decoration: InputDecoration(
                      fillColor: const Color.fromARGB(166, 255, 255, 255),
                      hintText: 'Type your status here..',
                      hintStyle: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
                heightBox12,
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    radius: Radius.circular(8),
                    padding: EdgeInsets.all(12),
                    color: Colors.white,
                    strokeWidth: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      child: SizedBox(
                        height: 160,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: _pickFile,
                                child: Icon(
                                  Icons.upload,
                                  size: 50,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                _selectedPostType == 'Reels'
                                    ? 'Drop your video here, or browse (mp4, mov allowed)'
                                    : 'Drop your file here, or browse (jpg, png, mp4, mov allowed)',
                                style: TextStyle(
                                    fontSize: 10, color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                heightBox12,
                _selectedFile != null
                    ? SizedBox(
                        height: 150.h,
                        child: Container(
                          width: 100.w,
                          height: 100.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.white,
                              width: 1,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: _selectedFile!.path!.endsWith('.mp4') ||
                                    _selectedFile!.path!.endsWith('.mov')
                                ? const Icon(Icons.videocam,
                                    size: 50, color: Colors.white)
                                : Image.file(
                                    File(_selectedFile!.path!),
                                    width: 100.w,
                                    height: 100.h,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      )
                    : Container(),
                heightBox20,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> createPostFunction(
      String userId, String description, String audience, String postType,
      {PlatformFile? contentFile}) async {
    if (_formKey.currentState!.validate()) {
      // Additional validation for Reels
      if (postType == 'Reels' && contentFile != null &&
          !(contentFile.extension == 'mp4' || contentFile.extension == 'mov')) {
        showSnackBarMessage(context, 'Only video files can be uploaded for Reels', true);
        return;
      }
      final bool isSuccess = await createPostController.createPost(
          userId, description, audience, postType,
          contentFile: contentFile);

      if (isSuccess) {
        if (mounted) {
          showSnackBarMessage(context, 'Post created');
        }
      } else {
        if (mounted) {
          showSnackBarMessage(
              context, createPostController.errorMessage!, true);
        }
      }
    }
  }
}

// import 'dart:io';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:windx1999/app/modules/post/views/post_audiences.dart';
// import 'package:windx1999/app/modules/post/widgets/post_dropdown_widget.dart';
// import 'package:windx1999/app/res/app_images/assets_path.dart';
// import 'package:windx1999/app/res/common_widgets/custom_app_bar.dart';
// import 'package:windx1999/app/res/common_widgets/custom_background.dart';
// import 'package:windx1999/app/res/custom_style/custom_size.dart';

// class PostScreen extends StatefulWidget {
//   final String audienceType;
//   const PostScreen({super.key, required this.audienceType});

//   @override
//   State<PostScreen> createState() => _PostScreenState();
// }

// class _PostScreenState extends State<PostScreen> {
//   List<PlatformFile> _selectedFiles = []; // List to store selected files
//   String? _selectedPostType; // To store the selected post type
//   final TextEditingController _statusController = TextEditingController();

//   // Method to pick multiple files (images and videos)
//   Future<void> _pickFiles() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       allowMultiple: true,
//       type: FileType.custom,
//       allowedExtensions: [
//         'jpg',
//         'jpeg',
//         'png',
//         'mp4',
//         'mov'
//       ], // Supported formats
//     );

//     if (result != null) {
//       setState(() {
//         _selectedFiles = result.files;
//       });
//     }
//   }

//   // Handle post type selection
//   void _onPostTypeChanged(String? value) {
//     setState(() {
//       _selectedPostType = value;
//       print('SelectedType: $_selectedPostType');
//     });
//     if (value != null) {
//       print('Selected post type: $value');
//     }
//   }

//   @override
//   void dispose() {
//     _statusController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomBackground(
//         child: Padding(
//           padding: EdgeInsets.all(16.0.h),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 heightBox20,
//                 CustomAppBar(
//                   title: 'New post',
//                   showButton: true,
//                   ontap: () {},
//                   color: Colors.white,
//                   textColor: Colors.grey,
//                 ),
//                 heightBox20,
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         CircleAvatar(
//                           backgroundImage: AssetImage(AssetsPath.blackGirl),
//                         ),
//                         widthBox5,
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Nammi Fatema',
//                               style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w600,
//                                   color: Colors.white),
//                             ),
//                             heightBox4,
//                             InkWell(
//                               onTap: () {
//                                 Get.to(PostAudiencesScreen());
//                               },
//                               child: Container(
//                                 height: 24.h,
//                                 width: 80.w,
//                                 decoration: BoxDecoration(
//                                   color: const Color(0xffEBF5FF),
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Icon(Icons.group, size: 14),
//                                     widthBox4,
//                                     Text(
//                                       'Friends',
//                                       style: TextStyle(
//                                         fontSize: 10.sp,
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     CustomDropdown(
//                       items: [
//                         'Reels',
//                         'Feed',
//                       ],
//                       hintText: 'Select post type',
//                       initialValue: 'Feed',
//                       onChanged: _onPostTypeChanged,
//                     ),
//                   ],
//                 ),
//                 heightBox20,
//                 TextFormField(
//                   controller: _statusController,
//                   style: TextStyle(color: Colors.white),
//                   maxLines: 4,
//                   decoration: InputDecoration(
//                       fillColor: const Color.fromARGB(166, 255, 255, 255),
//                       hintText: 'Type your status here..',
//                       hintStyle: TextStyle(fontSize: 16, color: Colors.white)),
//                 ),
//                 heightBox12,
//                 Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: DottedBorder(
//                     borderType: BorderType.RRect,
//                     radius: Radius.circular(8),
//                     padding: EdgeInsets.all(12),
//                     color: Colors.white,
//                     strokeWidth: 1,
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.all(Radius.circular(8)),
//                       child: SizedBox(
//                         height: 160,
//                         width: MediaQuery.of(context).size.width,
//                         child: Center(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               InkWell(
//                                 onTap: _pickFiles, // Call _pickFiles method
//                                 child: Icon(
//                                   Icons.upload,
//                                   size: 50,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                               Text(
//                                 'Drop your files here, or browse jpg, png, mp4, mov are allowed',
//                                 style: TextStyle(
//                                     fontSize: 10, color: Colors.white),
//                                 textAlign: TextAlign.center,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 heightBox12,
//                 // Display selected files
//                 _selectedFiles.isNotEmpty
//                     ? SizedBox(
//                         height: 150.h,
//                         child: ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           itemCount: _selectedFiles.length,
//                           itemBuilder: (context, index) {
//                             final file = _selectedFiles[index];
//                             return Padding(
//                               padding: EdgeInsets.only(right: 8.0),
//                               child: Container(
//                                 width: 100.w,
//                                 height: 100.h,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(
//                                       10), // Border radius
//                                   border: Border.all(
//                                     color: Colors.white,
//                                     width: 1,
//                                   ),
//                                 ),
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(10),
//                                   child: file.path!.endsWith('.mp4') ||
//                                           file.path!.endsWith('.mov')
//                                       ? const Icon(Icons.videocam,
//                                           size: 50, color: Colors.white)
//                                       : Image.file(
//                                           File(file.path!),
//                                           width: 100.w,
//                                           height: 100.h,
//                                           fit: BoxFit.cover,
//                                         ),
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       )
//                     : Container(),
//                 heightBox20,
               
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
