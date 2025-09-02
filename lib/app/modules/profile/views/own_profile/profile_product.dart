import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:windx1999/app/modules/profile/controllers/delete_wishlist_controller.dart';
import 'package:windx1999/app/modules/profile/controllers/refund_controller.dart';
import 'package:windx1999/app/modules/wishlist/controller/all_wishlist_controller.dart';
import 'package:windx1999/app/modules/wishlist/views/add_wish_list_screen.dart';
import 'package:windx1999/app/res/common_widgets/custom_dialoge.dart';
import 'package:windx1999/app/res/common_widgets/custom_rectangle_buttom.dart';
import 'package:windx1999/app/res/common_widgets/rectangle_button_with_icon.dart';
import 'package:windx1999/photo_view.dart';

class ProductListTile extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final String category;
  final Widget trailingIcon;
  final Widget? moreVertIcon;

  const ProductListTile({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.category,
    required this.trailingIcon,
    this.moreVertIcon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: GestureDetector(
        child: GestureDetector(
          onTap: () {
            Get.to(() => FullScreenImageViewer(imageUrl: imagePath));
          },
          child: Container(
              height: 48.h,
              width: 48.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(imagePath),
                    fit: BoxFit.cover,
                  ))),
        ),
      ),
      title: Text(title, style: TextStyle(color: Colors.white)),
      subtitle: Text(subtitle, style: TextStyle(color: Colors.grey)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          trailingIcon,
          if (moreVertIcon != null) moreVertIcon!,
        ],
      ),
    );
  }
}

// ProfileProduct Widget
class ProfileProduct extends StatefulWidget {
  const ProfileProduct({super.key});

  @override
  State<ProfileProduct> createState() => _ProfileProductState();
}

class _ProfileProductState extends State<ProfileProduct> {
  final AllWishlistController allWishlistController =
      Get.put(AllWishlistController());

  final DeleteWishlistController deleteWishlistController =
      Get.put(DeleteWishlistController());

  final RefundWishlistController refundWishlistController =
      Get.put(RefundWishlistController());
  final TextEditingController reasonCtrl = TextEditingController();

  @override
  void initState() {
    allWishlistController.getAllWishlist();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Get.to(CreateWishlistScreen());
          },
          child: Container(
            height: 40.h,
            width: 300.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Color(0xffFFFFFF).withOpacity(0.50),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(Icons.add), Text('Add more wishlist')],
            ),
          ),
        ),
        Expanded(
          child: GetBuilder<AllWishlistController>(builder: (controller) {
            if (controller.inProgress) {
              return SizedBox(
                height: 220,
                child: const Center(child: CircularProgressIndicator()),
              );
            }
            if (controller.allWishlistData!.isEmpty) {
              return SizedBox(
                height: 220,
                width: double.infinity,
                child: Center(
                  child: Text(
                    'No wishlist available',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
            }
            return Padding(
              padding: EdgeInsets.all(8.0.h),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: controller.allWishlistData?.length,
                itemBuilder: (context, index) {
                  var wishlist = controller.allWishlistData?[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    child: ProductListTile(
                      imagePath: wishlist!.content.isNotEmpty
                          ? wishlist.content[0]
                          : 'https://fastly.picsum.photos/id/376/200/300.jpg?hmac=gH_OWo7cSHKwU34tPONXdcjJuObIx0_5IswQHBjTXxg',
                      title: wishlist.title ?? 'no title',
                      subtitle: wishlist.description ?? 'no description',
                      category: 'Wishlist',
                      trailingIcon: RectangleButtonWithIcon(
                        height: 30,
                        width: 70,
                        bgColor: Color(0xff6CC7FE),
                        borderRadius: 8,
                        title: controller.allWishlistData?[index].price
                                .toString() ??
                            'no price',
                        titleColor: Colors.white,
                        titleSize: 12,
                        iconData: Icons.token_rounded,
                        iconColor: Colors.white,
                        iconSize: 16,
                        ontap: () {},
                      ),
                      moreVertIcon: PopupMenuButton<String>(
                        icon: Icon(Icons.more_vert, color: Colors.white),
                        onSelected: (String value) {
                          if (value == 'delete') {
                            _showDeleteWishlistDialog(context);
                          } else if (value == 'refund') {
                            _showRefundDialog(context);
                          }
                        },
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<String>>[
                          const PopupMenuItem<String>(
                            value: 'delete',
                            child: Text('Delete wishlist'),
                          ),
                          const PopupMenuItem<String>(
                            value: 'refund',
                            child: Text('Refund wishlist'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }),
        ),
      ],
    );
  }

  void _showRefundDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(20.h),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xffA062FA), Color(0xffA386F0)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12.0.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 10.h),
                Text(
                  'Write cancel resaon',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
                TextFormField(
                  maxLength: 30,
                  maxLines: 3,
                  controller: reasonCtrl,
                  decoration: InputDecoration(
                    hintText: 'Enter reason',
                    errorStyle: TextStyle(
                        color: const Color.fromARGB(255, 237, 82, 82)),
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomRectangleButton(
                      bgColor: Colors.white,
                      height: 40,
                      width: 120,
                      radiusSize: 12,
                      text: 'No',
                      ontap: () {
                        Navigator.pop(context);
                      },
                      borderColor: Colors.blue,
                      textColor: Colors.blue,
                    ),
                    SizedBox(width: 16),
                    CustomRectangleButton(
                      bgColor: Colors.blue,
                      height: 40,
                      width: 120,
                      radiusSize: 12,
                      text: 'Send',
                      ontap: () {
                        refundWishlist(
                            allWishlistController.allWishlistData?[0].id ?? '',
                            reasonCtrl.text);
                      },
                      borderColor: Colors.blue,
                      textColor: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showDeleteWishlistDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDeleteDialog(
          noOntap: () {
            Navigator.pop(context);
          },
          yesOntap: () {
            deleteWishlist(
                allWishlistController.allWishlistData?[0].id.toString() ?? '');
          },
          iconData: Icons.delete,
          subtitle: 'Do you want to delete this wishlist?',
          title: 'Delete',
        );
      },
    );
  }

  Future<void> deleteWishlist(String wishlistId) async {
    final bool isSuccess =
        await deleteWishlistController.deleteWishlist(wishlistId);

    if (isSuccess) {
      allWishlistController.getAllWishlist();
      Get.back();
    } else {
      Get.snackbar(
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.TOP,
        'Failed',
        'Failed to delete wishlist',
      );
    }
  }

  Future<void> refundWishlist(String wishlistId, String reason) async {
    final bool isSuccess =
        await refundWishlistController.refundWishlist(wishlistId, reason);

    if (isSuccess) {
      allWishlistController.getAllWishlist();
      Get.back();
    } else {
      Get.snackbar(
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.TOP,
        'Failed',
        'Failed to refund wishlist',
      );
    }
  }
}
