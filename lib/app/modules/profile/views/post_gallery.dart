import 'package:flutter/material.dart';
import 'package:windx1999/app/modules/profile/widgets/profile_dropdown.dart';
import 'package:windx1999/app/res/app_images/assets_path.dart';
import 'package:windx1999/app/res/common_widgets/image_container.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class PostGallery extends StatefulWidget {
  const PostGallery({super.key});

  @override
  State<PostGallery> createState() => _PostGalleryState();
}

class _PostGalleryState extends State<PostGallery> {
  String selectedOption = 'All';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
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
          Expanded(
            child: GridView.builder(
              itemCount: 15,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (context, index) {
                return ImageContainer(
                  imagePath: AssetsPath.blackGirl,
                  height: 100,
                  width: 100,
                  borderRadius: 0,
                  borderColor: Colors.transparent,
                  child: Align(
                    alignment: Alignment.topRight,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
