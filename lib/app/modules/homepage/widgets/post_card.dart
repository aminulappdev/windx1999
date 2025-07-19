import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import 'package:windx1999/app/modules/homepage/widgets/post_card_footer.dart';
import 'package:windx1999/app/modules/homepage/widgets/post_card_header.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class PostCard extends StatelessWidget {
  final bool isSaved;
  final bool isLiked;
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
    required this.isSaved,
    required this.aboutProfileTap,
    required this.isLiked,
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
                  icon: isLiked ? Icons.favorite : Icons.favorite_border,
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
  final Widget? child;

  const MediaContainer({
    super.key,
    required this.mediaPath,
    required this.height,
    required this.width,
    required this.borderColor,
    required this.borderRadius,
    this.child,
  });

  @override
  _MediaContainerState createState() => _MediaContainerState();
}

class _MediaContainerState extends State<MediaContainer> {
  VideoPlayerController? _controller;
  bool _isVideo = false;
  bool _isInitialized = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializeMedia();
  }

  void _initializeMedia() {
    print('Media Path: ${widget.mediaPath}'); // Debug log
    _isVideo = widget.mediaPath.toLowerCase().contains('/videos/');
    if (_isVideo) {
      _controller = VideoPlayerController.network(widget.mediaPath)
        ..initialize().then((_) {
          if (mounted) {
            setState(() {
              _isInitialized = true;
              _errorMessage = null;
            });
          }
        }).catchError((error) {
          if (mounted) {
            setState(() {
              _isInitialized = false;
              _errorMessage = 'Failed to load video: $error';
            });
          }
        });
    } else {
      _isInitialized = true;
      _errorMessage = null;
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
        child: Stack(
          children: [
            _errorMessage != null
                ? Container(
                    color: Colors.grey,
                    child: Center(
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                : _isVideo && _controller != null && _isInitialized
                    ? VideoPlayer(_controller!)
                    : _isInitialized
                        ? Image.network(
                            widget.mediaPath,
                            height: widget.height,
                            width: widget.width,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const Center(
                                  child: CircularProgressIndicator());
                            },
                            errorBuilder: (context, error, stackTrace) {
                              print('Image Load Error: $error'); // Debug log
                              return Container(
                                color: Colors.grey,
                                child: const Center(
                                  child: Text(
                                    'Failed to load image',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              );
                            },
                          )
                        : const Center(child: CircularProgressIndicator()),
            if (_isVideo && _isInitialized && _controller != null)
              Center(
                child: IconButton(
                  icon: Icon(
                    _controller!.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                    color: Colors.white,
                    size: 30.h,
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
              ),
            if (widget.child != null) widget.child!,
          ],
        ),
      ),
    );
  }
}
