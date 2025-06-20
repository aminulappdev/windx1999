import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:windx1999/app/modules/payment/controllers/payment_services.dart';
import 'package:windx1999/app/modules/token/controllers/all_package_controller.dart';
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
final PaymentService paymentService = PaymentService();

class _TokenBarState extends State<TokenBar> {
  bool tokenHistoryPage = true;

  @override
  void initState() {
    allPackageController.getAllPackage();
    super.initState();
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
              TokenBarHeader(
                imagePath: AssetsPath.blackGirl,
                token: '25.5k',
              ),
              heightBox20,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomRectangleButton(
                    textColor: Colors.white,
                    bgColor: tokenHistoryPage
                        ? Color(0xff6CC7FE)
                        : Colors.transparent,
                    height: 32,
                    width: 151,
                    radiusSize: 50,
                    text: 'Token history',
                    ontap: () {
                      setState(() {
                        tokenHistoryPage = true;
                      });
                    },
                    textSize: 16,
                    borderColor: tokenHistoryPage
                        ? Colors.transparent
                        : Color(0xff6CC7FE),
                  ),
                  CustomRectangleButton(
                    textColor: Colors.white,
                    bgColor: tokenHistoryPage
                        ? Colors.transparent
                        : Color(0xff6CC7FE),
                    height: 32,
                    width: 151,
                    radiusSize: 50,
                    text: 'Buy token',
                    ontap: () {
                      setState(() {
                        tokenHistoryPage = false;
                      });
                    },
                    textSize: 16,
                    borderColor: tokenHistoryPage
                        ? Color(0xff6CC7FE)
                        : Colors.transparent,
                  ),
                ],
              ),
              heightBox12,
              tokenHistoryPage ? Container() : StraightLiner(),
              heightBox12,
              GetBuilder<AllPackageController>(builder: (controller) {
                if (controller.inProgress) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return Expanded(
                  child: ListView.builder(
                    itemCount:
                        allPackageController.allPackageItemMOdel?.length ?? 2,
                    itemBuilder: (context, index) {
                      print(
                          'Token : ${allPackageController.allPackageModel?.data[index].token}');
                      return tokenHistoryPage
                          ? TokekDetailsScreen(
                              imagePath: AssetsPath.blackGirl,
                              title: 'You have Buy tokens',
                              date: '18/02/2025',
                              coin: '58.6k',
                              time: '09:54pm')
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
              })
            ],
          ),
        ),
      ),
    );
  }

  Future<void> orderPackage(String packageId) async {
    final bool isSuccess = await orderController.order(packageId: packageId);

    if (isSuccess) {
      if (mounted) {
        print('Order id controller: ${orderController.orderId}');     
        paymentService.payment(
          context,
          StorageUtil.getData(StorageUtil.userId),
          orderController.orderId ?? 'empty',
        );
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, orderController.errorMessage ?? 'Wrong', true);
      }
    }
  }
}
