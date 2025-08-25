// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:windx1999/app/modules/authentication/controllers/otp_verify_controller.dart';
import 'package:windx1999/app/services/network_caller/network_caller.dart';
import 'package:windx1999/app/services/network_caller/network_response.dart';
import 'package:windx1999/app/urls.dart';
import 'package:windx1999/get_storage.dart';

class RefundWishlistController extends GetxController {
  final OtpVerifyController otpVerifyController = OtpVerifyController();
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> refundWishlist(String uishlistId, String reason) async {
    bool isSuccess = false;

    _inProgress = true;

    update();

    final Map<String, dynamic> requestBody = {
      "order": uishlistId, // here add wishlistId
      "issues": reason
    };

    final NetworkResponse response =
        await Get.find<NetworkCaller>().postRequest(
      Urls.refundWishlistUrl,
      requestBody,
      accesToken: StorageUtil.getData(StorageUtil.userAccessToken),
    ); // Replace your api url

    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
