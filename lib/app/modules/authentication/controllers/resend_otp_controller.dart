// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:windx1999/app/modules/authentication/controllers/otp_verify_controller.dart';
import 'package:windx1999/app/modules/authentication/model/login_model.dart';
import 'package:windx1999/app/modules/authentication/model/resend_otp_response_modek.dart';
import 'package:windx1999/app/services/network_caller/network_caller.dart';
import 'package:windx1999/app/services/network_caller/network_response.dart';
import 'package:windx1999/app/urls.dart';

class ResendOtpController extends GetxController {
  final OtpVerifyController otpVerifyController = OtpVerifyController();
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  LoginResponseModel? loginResponseModel;
  LoginResponseItemModel? get loginData => loginResponseModel?.data;

  ResendOtpResponseModel? resendOtpResponseModel;
  ResendOtpData? get resendOtpData => resendOtpResponseModel?.data;

  String? _otpToken;
  String? get otpToken => _otpToken;

  Future<bool> resendOtp(String email) async {
    bool isSuccess = false;

    _inProgress = true;

    update();

    Map<String, dynamic> requestBody = {
      "email": email,
    }; // Replace your body data

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(Urls.resendOtpUrl, requestBody); // Replace your api url

    if (response.isSuccess) {
      // Accessing the otpToken from the response data safely
      resendOtpResponseModel =
          ResendOtpResponseModel.fromJson(response.responseData);
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
