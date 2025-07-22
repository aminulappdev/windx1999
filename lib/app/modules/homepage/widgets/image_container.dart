
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

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
