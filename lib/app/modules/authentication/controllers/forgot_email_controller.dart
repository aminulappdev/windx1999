// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:windx1999/app/modules/authentication/controllers/otp_verify_controller.dart';
import 'package:windx1999/app/modules/authentication/model/forgot_email_response_model.dart';
import 'package:windx1999/app/services/network_caller/network_caller.dart';
import 'package:windx1999/app/services/network_caller/network_response.dart';
import 'package:windx1999/app/urls.dart';

class ForgotEmailController extends GetxController {
  final OtpVerifyController otpVerifyController = OtpVerifyController();
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  ForgotEmailResponseModel? forgotEmailResponseModel;
  ForgotEmailData? get forgotData => forgotEmailResponseModel?.data;

  String? _otpToken;
  String? get otpToken => _otpToken;

  Future<bool> forgotEmail(String email) async {
    bool isSuccess = false;

    _inProgress = true;

    update();

    Map<String, dynamic> requestBody = {
      "email": email,
    }; // Replace your body data

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(Urls.forgotEmailUrl, requestBody); // Replace your api url

    if (response.isSuccess) {
      forgotEmailResponseModel =
          ForgotEmailResponseModel.fromJson(response.responseData);

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
