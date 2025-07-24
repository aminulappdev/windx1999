import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:windx1999/app/modules/payment/controllers/payment_services.dart';
import 'package:windx1999/app/modules/profile/controllers/profile_controller.dart';
import 'package:windx1999/app/modules/token/controllers/all_package_controller.dart';
import 'package:windx1999/app/modules/token/controllers/my_order_controller.dart';
import 'package:windx1999/app/modules/token/controllers/order_controller.dart';
import 'package:windx1999/app/modules/token/views/buy_token_screen.dart';
import 'package:windx1999/app/modules/token/views/token_details_screen.dart';
import 'package:windx1999/app/modules/token/widgets/token_bar_header.dart';
import 'package:windx1999/app/res/app_images/assets_path.dart';
import 'package:windx1999/app/res/common_widgets/custom_app_bar.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/common_widgets/custom_rectangle_buttom.dart';
import 'package:windx1999/app/res/common_widgets/custom_snackbar.dart';
import 'package:windx1999/app/res/common_widgets/straight_liner.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';
import 'package:windx1999/get_storage.dart';

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

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    await Future.wait([
      allPackageController.getAllPackage(),
      profileController.getMyProfile(),
      myOrderController.getMyOrders(),
    ]);
    setState(() {}); // UI refresh after data load
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heightBox20,
              CustomAppBar(title: 'Token details'),
              heightBox50,
              GetBuilder<ProfileController>(builder: (controller) {
                return TokenBarHeader(
                  imagePath:
                      'https://fastly.picsum.photos/id/51/200/300.jpg?hmac=w7933XDRbSqrql6BuyEfFBOeVsO60iU5N_OS5FbO6wQ',
                  token:
                      profileController.profileData?.tokenAmount.toString() ??
                          '0',
                );
              }),
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
                    ontap: () async {
                      setState(() {
                        tokenHistoryPage = true;
                      });
                      await myOrderController.getMyOrders(); // Refresh data
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
              tokenHistoryPage ? Container() : StraightLiner(),
              heightBox12,
              GetBuilder<AllPackageController>(builder: (controller) {
                if (controller.inProgress || myOrderController.inProgress) {
                  return const Center(child: CircularProgressIndicator());
                }

                return Expanded(
                  child: ListView.builder(
                    itemCount: tokenHistoryPage
                        ? myOrderController.myOrdersData?.length ?? 0
                        : allPackageController.allPackageItemMOdel?.length ?? 0,
                    itemBuilder: (context, index) {
                      return tokenHistoryPage
                          ? GetBuilder<MyOrderController>(
                              builder: (oController) {
                                final createdAt = oController
                                    .myOrdersData?[index].createdAt
                                    ?.toString();

                                return TokekDetailsScreen(
                                  imagePath: AssetsPath.blackGirl,
                                  title: 'You have Buy tokens',
                                  date: formatDate(createdAt),
                                  coin: oController.myOrdersData?[index].amount
                                          .toString() ??
                                      '0',
                                  time: formatTime(createdAt),
                                );
                              },
                            )
                          : BuyTokenScreen(
                              token: allPackageController
                                      .allPackageModel?.data[index].token
                                      .toString() ??
                                  '0',
                              price: allPackageController
                                      .allPackageModel?.data[index].price
                                      .toString() ??
                                  '0',
                              ontap: () {
                                orderPackage(
                                  controller.allPackageModel?.data[index].id
                                          .toString() ??
                                      '',
                                );
                              },
                            );
                    },
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> orderPackage(String packageId) async {
    final bool isSuccess = await orderController.order(packageId: packageId);

    if (isSuccess && mounted) {
      paymentService.payment(
        context,
        StorageUtil.getData(StorageUtil.userId),
        orderController.orderId ?? 'empty',
      );
    } else if (mounted) {
      showSnackBarMessage(
          context, orderController.errorMessage ?? 'Wrong', true);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
