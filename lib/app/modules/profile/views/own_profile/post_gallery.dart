import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:windx1999/app/modules/homepage/widgets/image_container.dart';
import 'package:windx1999/app/modules/profile/controllers/all_feed_controller.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';
import 'package:windx1999/get_storage.dart';
import 'package:windx1999/photo_view.dart';

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

  // Filter the feed data based on the selected option
  List<dynamic> _filterFeedData(List<dynamic>? feedData) {
    if (feedData == null || feedData.isEmpty) return [];

    switch (selectedOption) {
      case 'Images':
        return feedData
            .where((item) =>
                item.content.isNotEmpty &&
                !item.content[0].toString().toLowerCase().contains('/videos/'))
            .toList();
      case 'Videos':
        return feedData
            .where((item) =>
                item.content.isNotEmpty &&
                item.content[0].toString().toLowerCase().contains('/videos/'))
            .toList();
      case 'All':
      default:
        return feedData;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12.h, left: 12.w, right: 12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('All images and videos', style: TextStyle(color: Colors.white, fontSize: 18.sp,fontWeight: FontWeight.w600)),
          heightBox12,
          GetBuilder<AllFeedController>(builder: (controller) {
            if (controller.inProgress) {
              return const Center(child: CircularProgressIndicator());
            }

            // Filter the data based on the selected option
            final filteredData = _filterFeedData(controller.allFeedData);

            if (filteredData.isEmpty) {
              return SizedBox(
                height: 220,
                child: const Center(child: Text('No media available',style: TextStyle(color: Colors.white),)));
            }

            return Expanded(
              child: GridView.builder(
                itemCount: filteredData.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                ),
                itemBuilder: (context, index) {
                  final item = filteredData[index];

                  // Check if content is null or empty
                  if (item != null && item.content.isNotEmpty) {
                    final mediaUrl = item.content[0];

                    // Optional: check if mediaUrl is valid
                    if (mediaUrl.isNotEmpty) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => FullScreenImageViewer(imageUrl: mediaUrl!));
                        },
                        child: MediaContainer(
                          mediaPath: mediaUrl,
                          height: 100.h,
                          width: 100.w,
                          borderRadius: 0,
                          borderColor: Colors.transparent,
                          child: const Align(
                            alignment: Alignment.topRight,
                          ),
                        ),
                      );
                    }
                  }

                  // If media not available, return a placeholder
                  return Container(
                    height: 100.h,
                    width: 100.w,
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