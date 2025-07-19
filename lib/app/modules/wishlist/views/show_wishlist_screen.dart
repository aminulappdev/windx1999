import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:windx1999/app/modules/wishlist/controller/wishlist_details_controller.dart';
import 'package:windx1999/app/res/common_widgets/custom_app_bar.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/common_widgets/image_container.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class ShowWishlistScreen extends StatefulWidget {
  final String wishlistId;
  const ShowWishlistScreen({super.key, required this.wishlistId});

  @override
  State<ShowWishlistScreen> createState() => _ShowWishlistScreenState();
}

class _ShowWishlistScreenState extends State<ShowWishlistScreen> {
  final WishlistDetailsController wishlistDetailsController =
      Get.put(WishlistDetailsController());

  @override
  void initState() {
    wishlistDetailsController.getWishlistDetails(widget.wishlistId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0.h),
            child: GetBuilder<WishlistDetailsController>(builder: (controller) {
              if (controller.inProgress) {
                return Center(
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return Column(
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
                          style:
                              TextStyle(fontSize: 16.sp, color: Colors.white),
                        ),
                        heightBox10,
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color.fromARGB(255, 255, 255, 255),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${controller.wishlistData?.title}',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        heightBox20,
                        Text(
                          'Descrption',
                          style:
                              TextStyle(fontSize: 16.sp, color: Colors.white),
                        ),
                        heightBox10,
                        Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color.fromARGB(255, 255, 255, 255),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${controller.wishlistData?.description}',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        heightBox20,
                        Text(
                          'Product link',
                          style:
                              TextStyle(fontSize: 16.sp, color: Colors.white),
                        ),
                        heightBox10,
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color.fromARGB(255, 255, 255, 255),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${controller.wishlistData?.link}',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        heightBox20,
                        Text(
                          'Product price',
                          style:
                              TextStyle(fontSize: 16.sp, color: Colors.white),
                        ),
                        heightBox10,
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color.fromARGB(255, 255, 255, 255),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${controller.wishlistData?.price}',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        heightBox20,
                        Text(
                          'Product Image',
                          style:
                              TextStyle(fontSize: 16.sp, color: Colors.white),
                        ),
                        heightBox10,
                        controller.wishlistData!.content.isEmpty
                            ? Container()
                            : ImageContainer(
                                imagePath: controller
                                        .wishlistData!.content.isEmpty
                                    ? 'https://fastly.picsum.photos/id/966/200/300.jpg?hmac=vBALR2x0cV-keVNLecwjd8ZluSHv17AHDvpiYjBqar0'
                                    : controller.wishlistData?.content[0],
                                height: 212.h,
                                width: MediaQuery.of(context).size.width,
                                borderRadius: 12,
                                borderColor: Colors.transparent),
                      ],
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
