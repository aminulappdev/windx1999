import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:windx1999/app/modules/token/controllers/my_order_controller.dart';
import 'package:windx1999/app/modules/token/views/token_details_screen.dart';
import 'package:windx1999/app/res/app_images/assets_path.dart';
import 'package:intl/intl.dart';

class TokenHistoryScreen extends StatefulWidget {
  final String imagePath;
  const TokenHistoryScreen({super.key, required this.imagePath});

  @override
  State<TokenHistoryScreen> createState() => _TokenHistoryScreenState();
}

class _TokenHistoryScreenState extends State<TokenHistoryScreen> {
  final MyOrderController myOrderController = Get.put(MyOrderController());

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
    myOrderController.getMyOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GetBuilder<MyOrderController>(builder: (controller) {
        if (myOrderController.inProgress) {
          return const Center(child: CircularProgressIndicator());
        }
        return Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: myOrderController.myOrdersData?.length ?? 0,
            itemBuilder: (context, index) {
              final createdAt =
                  myOrderController.myOrdersData?[index].createdAt?.toString();
              return TokekDetailsScreen(
                imagePath: widget.imagePath,
                title: 'You have Buy tokens',
                date: formatDate(createdAt),
                coin:
                    myOrderController.myOrdersData?[index].amount.toString() ??
                        '0',
                time: formatTime(createdAt),
              );
            },
          ),
        );
      }),
    );
  }
}
