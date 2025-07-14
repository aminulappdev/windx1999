// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:windx1999/app/modules/homepage/widgets/post_card_footer.dart';
// import 'package:windx1999/app/modules/homepage/widgets/post_card_header.dart';
// import 'package:windx1999/app/res/common_widgets/image_container.dart';
// import 'package:windx1999/app/res/custom_style/custom_size.dart';

// class PostCard extends StatelessWidget {
//   final bool isSaved;
//   final bool iSVisibleWishlist;
//   final String profilePath;
//   final String name;
//   final String activeStatus;
//   final VoidCallback addFriendOnTap;
//   final VoidCallback wishListOnTap;
//   final VoidCallback moreVertOntap;
//   final String text;
//   final String? imagePath;
//   final String react;
//   final String comment;
//   final VoidCallback commentOnTap;
//   final String share;
//   final VoidCallback reactOntap;
//   final VoidCallback bookmarkOntap;
//   final Color bgColor;

//   const PostCard({
//     super.key,
//     required this.profilePath,
//     required this.name,
//     required this.activeStatus,
//     required this.addFriendOnTap,
//     required this.wishListOnTap,
//     required this.moreVertOntap,
//     required this.text,
//     this.imagePath,
//     required this.react,
//     required this.comment,
//     required this.commentOnTap,
//     required this.share,
//     required this.reactOntap,
//     required this.bookmarkOntap, required this.bgColor, required this.iSVisibleWishlist, required this.isSaved,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         color:  bgColor,
//       ),
//       child: Padding(
//         padding: EdgeInsets.all(8.0.h),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             PostCardHeader(
//                 isShowWishlist: iSVisibleWishlist,
//                 profilePath: profilePath,
//                 name: name,
//                 addFriendOnTap: addFriendOnTap,
//                 activeStatus: activeStatus,
//                 wishListOnTap: wishListOnTap,
//                 moreVertOntap: moreVertOntap),
//             heightBox8,
//             Text(
//               text,
//               style: TextStyle(color: Colors.white),
//               textAlign: TextAlign.justify,
//             ),
//             heightBox12,
//             // ignore: unnecessary_null_comparison
//             imagePath != null
//                 ? ImageContainer(
//                     imagePath: imagePath,
//                     height: 250.h,
//                     width: MediaQuery.of(context).size.width,
//                     borderColor: Colors.white,
//                     borderRadius: 12.r,
//                   )
//                 : Container(),
//             heightBox8,
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 PostCardFoterFeature(
//                   icon: react == '0' ? Icons.favorite_border : Icons.favorite,
//                   ontap: reactOntap,
//                   quantity: react,
//                 ),
//                 PostCardFoterFeature(
//                   icon: Icons.sms,
//                   ontap: commentOnTap,
//                   quantity: comment,
//                 ),
//                 // PostCardFoterFeature(
//                 //   icon: Icons.share,
//                 //   ontap: shareOntap,
//                 //   quantity: share,
//                 // ),
//                 GestureDetector(
//                   onTap: bookmarkOntap,
//                   child: Icon(
//                    isSaved ? Icons.bookmark :  Icons.bookmark_border,
//                     color: Colors.white,
//                     size: 28.h,
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import 'package:windx1999/app/modules/homepage/widgets/post_card_footer.dart';
import 'package:windx1999/app/modules/homepage/widgets/post_card_header.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class PostCard extends StatelessWidget {
  final bool isSaved;
  final bool iSVisibleWishlist;
  final String profilePath;
  final String name;
  final String activeStatus;
  final VoidCallback addFriendOnTap;
  final VoidCallback wishListOnTap;
  final VoidCallback moreVertOntap;
  final String text;
  final String? imagePath;
  final String react;
  final String comment;
  final VoidCallback commentOnTap;
  final String share;
  final VoidCallback reactOntap;
  final VoidCallback bookmarkOntap;
  final Color bgColor;
  final VoidCallback aboutProfileTap;
  const PostCard({
    super.key,
    required this.profilePath,
    required this.name,
    required this.activeStatus,
    required this.addFriendOnTap,
    required this.wishListOnTap,
    required this.moreVertOntap,
    required this.text,
    this.imagePath,
    required this.react,
    required this.comment,
    required this.commentOnTap,
    required this.share,
    required this.reactOntap,
    required this.bookmarkOntap,
    required this.bgColor,
    required this.iSVisibleWishlist,
    required this.isSaved, required this.aboutProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: bgColor,
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: aboutProfileTap,
              child: PostCardHeader(
                isShowWishlist: iSVisibleWishlist,
                profilePath: profilePath,
                name: name,
                addFriendOnTap: addFriendOnTap,
                activeStatus: activeStatus,
                wishListOnTap: wishListOnTap,
                moreVertOntap: moreVertOntap,
              ),
            ),
            heightBox8,
            Text(
              text,
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.justify,
            ),
            heightBox12,
            imagePath != null
                ? MediaContainer(
                    mediaPath: imagePath!,
                    height: 250.h,
                    width: MediaQuery.of(context).size.width,
                    borderColor: Colors.white,
                    borderRadius: 12.r,
                  )
                : Container(),
            heightBox8,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                PostCardFoterFeature(
                  icon: react == '0' ? Icons.favorite_border : Icons.favorite,
                  ontap: reactOntap,
                  quantity: react,
                ),
                PostCardFoterFeature(
                  icon: Icons.sms,
                  ontap: commentOnTap,
                  quantity: comment,
                ),
                GestureDetector(
                  onTap: bookmarkOntap,
                  child: Icon(
                    isSaved ? Icons.bookmark : Icons.bookmark_border,
                    color: Colors.white,
                    size: 28.h,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MediaContainer extends StatefulWidget {
  final String mediaPath;
  final double height;
  final double width;
  final Color borderColor;
  final double borderRadius;

  const MediaContainer({
    super.key,
    required this.mediaPath,
    required this.height,
    required this.width,
    required this.borderColor,
    required this.borderRadius,
  });

  @override
  _MediaContainerState createState() => _MediaContainerState();
}

class _MediaContainerState extends State<MediaContainer> {
  VideoPlayerController? _controller;
  bool _isVideo = false;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeMedia();
  }

  void _initializeMedia() {
    // Determine if the media is a video based on file extension
    final videoExtensions = ['.mp4', '.mov', '.avi', '.mkv'];
    _isVideo = videoExtensions
        .any((ext) => widget.mediaPath.toLowerCase().endsWith(ext));

    if (_isVideo) {
      _controller = VideoPlayerController.network(widget.mediaPath)
        ..initialize().then((_) {
          setState(() {
            _isInitialized = true;
          });
        }).catchError((error) {
          setState(() {
            _isInitialized = false;
          });
        });
    } else {
      _isInitialized = true;
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        border: Border.all(color: widget.borderColor),
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: _isVideo && _controller != null && _isInitialized
            ? Stack(
                alignment: Alignment.center,
                children: [
                  VideoPlayer(_controller!),
                  IconButton(
                    icon: Icon(
                      _controller!.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                      color: Colors.white,
                      size: 50.h,
                    ),
                    onPressed: () {
                      setState(() {
                        if (_controller!.value.isPlaying) {
                          _controller!.pause();
                        } else {
                          _controller!.play();
                        }
                      });
                    },
                  ),
                ],
              )
            : _isInitialized
                ? Image.network(
                    widget.mediaPath,
                    height: widget.height,
                    width: widget.width,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey,
                      child: Center(child: Text('Failed to load media')),
                    ),
                  )
                : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
