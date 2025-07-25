import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:windx1999/app/modules/payment/controllers/payment_services.dart';
import 'package:windx1999/app/modules/profile/controllers/profile_controller.dart';
import 'package:windx1999/app/modules/token/controllers/all_package_controller.dart';
import 'package:windx1999/app/modules/token/controllers/my_order_controller.dart';
import 'package:windx1999/app/modules/token/controllers/order_controller.dart';
import 'package:windx1999/app/modules/token/views/all_token_screen.dart';
import 'package:windx1999/app/modules/token/views/token_history_screen.dart';
import 'package:windx1999/app/modules/token/widgets/token_bar_header.dart';
import 'package:windx1999/app/res/common_widgets/custom_app_bar.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/common_widgets/custom_rectangle_buttom.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class TokenBar extends StatefulWidget {
  const TokenBar({super.key});

  @override
  State<TokenBar> createState() => _TokenBarState();
}

AllPackageController allPackageController = Get.put(AllPackageController());
final OrderController orderController = Get.put(OrderController());
final ProfileController profileController = Get.put(ProfileController());
final PaymentService paymentService = PaymentService();
final MyOrderController myOrderController = Get.put(MyOrderController());

class _TokenBarState extends State<TokenBar> {
  bool tokenHistoryPage = true;
  int selectedPage = 1;

  @override
  void initState() {
    super.initState();
    // Defer data loading until after the build phase
    WidgetsBinding.instance.addPostFrameCallback((_) {
      profileController.getMyProfile();
    });
  }

  String formatDate(String? dateTimeStr) {
    if (dateTimeStr == null) return '';
    try {
      final dateTime = DateTime.parse(dateTimeStr);
      return DateFormat('dd MMM yyyy').format(dateTime);
    } catch (e) {
      return dateTimeStr;
    }
  }

  String formatTime(String? dateTimeStr) {
    if (dateTimeStr == null) return '';
    try {
      final dateTime = DateTime.parse(dateTimeStr);
      return DateFormat('hh:mm a').format(dateTime);
    } catch (e) {
      return dateTimeStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        child: Padding(
          padding: EdgeInsets.all(16.0.h),
          child: GetBuilder<ProfileController>(builder: (controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                heightBox20,
                CustomAppBar(title: 'Token details'),
                heightBox50,
                TokenBarHeader(
                  imagePath: controller.profileData?.photoUrl ??
                      'https://fastly.picsum.photos/id/51/200/300.jpg?hmac=w7933XDRbSqrql6BuyEfFBOeVsO60iU5N_OS5FbO6wQ',
                  token: controller.profileData?.tokenAmount.toString() ?? '0',
                ),
                heightBox20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomRectangleButton(
                      textColor: Colors.white,
                      bgColor: tokenHistoryPage
                          ? const Color(0xff6CC7FE)
                          : Colors.transparent,
                      height: 32,
                      width: 151,
                      radiusSize: 50,
                      text: 'Token history',
                      ontap: () {
                        setState(() {
                          tokenHistoryPage = true;
                          selectedPage = 1;
                        });
                      },
                      textSize: 16,
                      borderColor: tokenHistoryPage
                          ? Colors.transparent
                          : const Color(0xff6CC7FE),
                    ),
                    CustomRectangleButton(
                      textColor: Colors.white,
                      bgColor: tokenHistoryPage
                          ? Colors.transparent
                          : const Color(0xff6CC7FE),
                      height: 32,
                      width: 151,
                      radiusSize: 50,
                      text: 'Buy token',
                      ontap: () async {
                        setState(() {
                          tokenHistoryPage = false;
                          selectedPage = 2;
                        });
                        await allPackageController
                            .getAllPackage(); // Refresh data
                      },
                      textSize: 16,
                      borderColor: tokenHistoryPage
                          ? const Color(0xff6CC7FE)
                          : Colors.transparent,
                    ),
                  ],
                ),
                heightBox12,
                if (selectedPage == 1) ...{
                  TokenHistoryScreen(
                    imagePath: controller.profileData?.photoUrl ??
                        'https://fastly.picsum.photos/id/51/200/300.jpg?hmac=w7933XDRbSqrql6BuyEfFBOeVsO60iU5N_OS5FbO6wQ',
                  ),
                } else if (selectedPage == 2) ...{
                  AllTokenScreen()
                }
              ],
            );
          }),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
