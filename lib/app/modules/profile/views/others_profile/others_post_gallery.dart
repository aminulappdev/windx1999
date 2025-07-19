import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:windx1999/app/modules/homepage/widgets/post_card.dart';
import 'package:windx1999/app/modules/profile/controllers/all_feed_controller.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';
import 'package:video_player/video_player.dart';

class OthersPostGallery extends StatefulWidget {
  final String userId;
  const OthersPostGallery({super.key, required this.userId});

  @override
  State<OthersPostGallery> createState() => _OthersPostGalleryState();
}

class _OthersPostGalleryState extends State<OthersPostGallery> {
  final AllFeedController allFeedController = Get.put(AllFeedController());

  @override
  void initState() {
    super.initState();
    allFeedController.getAllFeed(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12.h, left: 12.w, right: 12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'All images and videos',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          heightBox12,
          GetBuilder<AllFeedController>(builder: (controller) {
            if (controller.inProgress) {
              return const Center(child: CircularProgressIndicator());
            }

            final feedData = controller.allFeedData;

            if (feedData == null || feedData.isEmpty) {
              return const Center(child: Text('No media available', style: TextStyle(color: Colors.white)));
            }

            return Expanded(
              child: GridView.builder(
                itemCount: feedData.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                ),
                itemBuilder: (context, index) {
                  final item = feedData[index];

                  // Check if content is null or empty
                  if (item != null && item.content.isNotEmpty) {
                    final mediaUrl = item.content[0];

                    // Check if mediaUrl is valid
                    if (mediaUrl.isNotEmpty) {
                      return MediaContainer(
                        mediaPath: mediaUrl,
                        height: 100.h,
                        width: 100.w,
                        borderRadius: 0,
                        borderColor: Colors.transparent,
                        child: const Align(
                          alignment: Alignment.topRight,
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
