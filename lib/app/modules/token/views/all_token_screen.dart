// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:windx1999/app/modules/token/controllers/all_package_controller.dart';
import 'package:windx1999/app/modules/token/controllers/order_controller.dart';
import 'package:windx1999/app/modules/token/views/buy_token_screen.dart';
import 'package:windx1999/app/modules/token/views/token_bar.dart';
import 'package:windx1999/app/modules/token/views/token_details_screen.dart';
import 'package:windx1999/app/res/app_images/assets_path.dart';
import 'package:intl/intl.dart';
import 'package:windx1999/app/res/common_widgets/custom_snackbar.dart';
import 'package:windx1999/get_storage.dart';

class AllTokenScreen extends StatefulWidget {
  const AllTokenScreen({super.key});

  @override
  State<AllTokenScreen> createState() => _AllTokenScreenState();
}

class _AllTokenScreenState extends State<AllTokenScreen> {
  AllPackageController allPackageController = Get.put(AllPackageController());
  final OrderController orderController = Get.put(OrderController());

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
  void initState() {
    allPackageController.getAllPackage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GetBuilder<AllPackageController>(builder: (controller) {
        if (allPackageController.inProgress) {
          return const Center(child: CircularProgressIndicator());
        }
        return Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: allPackageController.allPackageItemMOdel?.length ?? 0,
            itemBuilder: (context, index) {
              return BuyTokenScreen(
                token: allPackageController.allPackageModel?.data[index].token
                        .toString() ??
                    '0',
                price: allPackageController.allPackageModel?.data[index].price
                        .toString() ??
                    '0',
                ontap: () {
                  orderPackage(
                    controller.allPackageModel?.data[index].id.toString() ?? '',
                  );
                },
              );
            },
          ),
        );
      }),
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
}
