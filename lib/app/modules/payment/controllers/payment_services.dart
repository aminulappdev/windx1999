// payment_service.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:windx1999/app/modules/payment/controllers/payment_controller.dart';
import 'package:windx1999/app/modules/payment/views/payment_webview_screen.dart';
import 'package:windx1999/app/res/common_widgets/custom_snackbar.dart';

class PaymentService {
  final PaymentController paymentController = PaymentController();

  Future<void> payment(BuildContext context, String userId,
      String referenceId) async {
    final bool isSuccess =
        await paymentController.getPayment(userId, referenceId);

    Map<String, dynamic> paymentData = {
      'link': paymentController.paymentData?.data,
      'reference': referenceId
    };

    if (isSuccess) {
      // Directly use context without mounted check
      showSnackBarMessage(context, 'Payment request done');
      Get.to(PaymentWebviewScreen(paymentData: paymentData));
    } else {
      // Error handling
      showSnackBarMessage(context,
          paymentController.errorMessage ?? 'There was a problem', true);
    }
  }
}
