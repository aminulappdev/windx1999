import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windx1999/app/res/app_images/assets_path.dart';
import 'package:windx1999/app/res/common_widgets/custom_app_bar.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/common_widgets/image_container.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class ShowWishlistScreen extends StatefulWidget {
  const ShowWishlistScreen({super.key});

  @override
  State<ShowWishlistScreen> createState() => _ShowWishlistScreenState();
}

class _ShowWishlistScreenState extends State<ShowWishlistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomBackground(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                 heightBox20,
                  CustomAppBar(title: 'David wavy Wishlist'),
                  heightBox20,
                  Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Title',
                          style: TextStyle(fontSize: 16.sp, color: Colors.white),
                        ),
                        heightBox10,
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Enter title your product',
                            errorStyle: TextStyle(
                                color: const Color.fromARGB(255, 237, 82, 82)),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.emailAddress,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Enter title';
                            }
                            return null;
                          },
                        ),
                        heightBox20,
                        Text(
                          'Descrption',
                          style: TextStyle(fontSize: 16.sp, color: Colors.white),
                        ),
                        heightBox10,
                        TextFormField(
                          maxLines: 4,
                          decoration: InputDecoration(
                            hintText: 'Enter description your product',
                            errorStyle: TextStyle(
                                color: const Color.fromARGB(255, 237, 82, 82)),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.emailAddress,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Enter address';
                            }
                            return null;
                          },
                        ),
                        heightBox20,
                        Text(
                          'Product link',
                          style: TextStyle(fontSize: 16.sp, color: Colors.white),
                        ),
                        heightBox10,
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Enter product link',
                            errorStyle: TextStyle(
                                color: const Color.fromARGB(255, 237, 82, 82)),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.emailAddress,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Enter product link';
                            }
                            return null;
                          },
                        ),
                        heightBox20,
                        Text(
                          'Product price',
                          style: TextStyle(fontSize: 16.sp, color: Colors.white),
                        ),
                        heightBox10,
                        TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.money),
                            hintText: 'Enter product price',
                            errorStyle: TextStyle(
                                color: const Color.fromARGB(255, 237, 82, 82)),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.emailAddress,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Enter product link';
                            }
                            return null;
                          },
                        ),
                        heightBox20,
                        Text(
                          'Product price',
                          style: TextStyle(fontSize: 16.sp, color: Colors.white),
                        ),
                        heightBox10,
                        ImageContainer(
                            imagePath: AssetsPath.blackGirl,
                            height: 212.h,
                            width: MediaQuery.of(context).size.width,
                            borderRadius: 12,
                            borderColor: Colors.transparent),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      
    );
  }
}
