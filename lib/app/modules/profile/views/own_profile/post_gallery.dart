import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:windx1999/app/modules/profile/controllers/all_feed_controller.dart';
import 'package:windx1999/app/modules/profile/widgets/profile_dropdown.dart';
import 'package:windx1999/app/res/common_widgets/image_container.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';
import 'package:windx1999/get_storage.dart';

class PostGallery extends StatefulWidget {
  const PostGallery({super.key});

  @override
  State<PostGallery> createState() => _PostGalleryState();
}

class _PostGalleryState extends State<PostGallery> {
  final AllFeedController allFeedController = Get.put(AllFeedController());
  String selectedOption = 'All';

  @override
  void initState() {
    super.initState();
    allFeedController.getAllFeed(StorageUtil.getData(StorageUtil.userId));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12.h, left: 12.w, right: 12.w),
      child: Column(
        children: [
          FilterDropdown(
            selectedOption: selectedOption,
            onOptionChanged: (String? newValue) {
              setState(() {
                selectedOption = newValue ?? 'All'; // Handle null value
              });
            },
          ),
          heightBox12,
          GetBuilder<AllFeedController>(builder: (controller) {
            if (controller.inProgress) {
              return const Center(child: CircularProgressIndicator());
            }

            return Expanded(
              child: GridView.builder(
                itemCount: controller.allFeedData?.length ?? 0,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (context, index) {
                  final item = controller.allFeedData?[index];

                  // Check if content is null or empty
                  if (item != null && item.content.isNotEmpty) {
                    final imageUrl = item.content[0];

                    // Optional: check if imageUrl is valid
                    if (imageUrl.isNotEmpty) {
                      return ImageContainer(
                        imagePath: imageUrl,
                        height: 100,
                        width: 100,
                        borderRadius: 0,
                        borderColor: Colors.transparent,
                        child: const Align(
                          alignment: Alignment.topRight,
                        ),
                      );
                    }
                  }

                  // If image not available, return a placeholder
                  return Container(
                    height: 100,
                    width: 100,
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.image_not_supported),
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
