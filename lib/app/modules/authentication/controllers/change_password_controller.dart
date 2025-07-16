// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:windx1999/app/modules/authentication/controllers/otp_verify_controller.dart';
import 'package:windx1999/app/services/network_caller/network_caller.dart';
import 'package:windx1999/app/services/network_caller/network_response.dart';
import 'package:windx1999/app/urls.dart';
import 'package:windx1999/get_storage.dart';

class ChangePasswordController extends GetxController {
  final OtpVerifyController otpVerifyController = OtpVerifyController();
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> changePassword(String currentpassword, String newpassword,
      String confirmpassword) async {
    bool isSuccess = false;

    _inProgress = true;

    update();

    Map<String, dynamic> requestBody = {
      "oldPassword": currentpassword,
      "newPassword": newpassword,
      "confirmPassword": confirmpassword
    }; // Replace your body data

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(Urls.changePasswordUrl,
            accesToken: StorageUtil.getData(StorageUtil.userAccessToken),
            requestBody); // Replace your api url

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
