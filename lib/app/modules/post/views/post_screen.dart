import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:windx1999/app/modules/post/views/post_audiences.dart';
import 'package:windx1999/app/modules/post/widgets/post_dropdown_widget.dart';
import 'package:windx1999/app/res/app_images/assets_path.dart';
import 'package:windx1999/app/res/common_widgets/custom_app_bar.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';



class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  List<PlatformFile> _selectedFiles = []; // List to store selected files
  String? _selectedPostType; // To store the selected post type
  final TextEditingController _statusController = TextEditingController();

  // Method to pick multiple files (images and videos)
  Future<void> _pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'mp4', 'mov'], // Supported formats
    );

    if (result != null) {
      setState(() {
        _selectedFiles = result.files;
      });
    }
  }

  // Handle post type selection
  void _onPostTypeChanged(String? value) {
    setState(() {
      _selectedPostType = value;
       print('SelectedType: $_selectedPostType');
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
                  ontap: () {},
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
                                      'Friends',
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
                      items: [
                        'Reels',
                        'Feed',
                      ],
                      hintText: 'Select post type',
                      initialValue: 'Feed',
                      onChanged: _onPostTypeChanged,
                    ),
                  ],
                ),
                heightBox20,
                TextFormField(
                  controller: _statusController,
                  style: TextStyle(color: Colors.white),
                  maxLines: 4,
                  decoration: InputDecoration(
                      fillColor: const Color.fromARGB(166, 255, 255, 255),
                      hintText: 'Type your status here..',
                      hintStyle: TextStyle(fontSize: 16, color: Colors.white)),
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
                                onTap: _pickFiles, // Call _pickFiles method
                                child: Icon(
                                  Icons.upload,
                                  size: 50,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Drop your files here, or browse jpg, png, mp4, mov are allowed',
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
                // Display selected files
                _selectedFiles.isNotEmpty
                    ? SizedBox(
                        height: 150.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _selectedFiles.length,
                          itemBuilder: (context, index) {
                            final file = _selectedFiles[index];
                            return Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Container(
                                width: 100.w,
                                height: 100.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      10), // Border radius
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: file.path!.endsWith('.mp4') || file.path!.endsWith('.mov')
                                      ? const Icon(Icons.videocam, size: 50, color: Colors.white)
                                      : Image.file(
                                          File(file.path!),
                                          width: 100.w,
                                          height: 100.h,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : Container(),
                heightBox20,
                // Add post button
                // Center(
                //   child: ElevatedButton(
                //     onPressed: _post,
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: Color(0xffA96CFF),
                //       padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 12.h),
                //     ),
                //     child: Text('Post', style: TextStyle(color: Colors.white, fontSize: 16.sp)),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}