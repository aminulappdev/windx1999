// ignore_for_file: avoid_print
import 'package:get/get.dart';
import 'package:windx1999/app/services/network_caller/network_caller.dart';
import 'package:windx1999/app/services/network_caller/network_response.dart';
import 'package:windx1999/app/urls.dart';


class OtpVerifyController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _otpToken;
  String? get otpToken => _otpToken;

  // Setter for otpToken
  set otpToken(String? value) {
    _otpToken = value;
    update();
  }

  Future<bool> otpVerify(String otpNumber, String otpTokenUser) async {
    print('Token is main : $otpTokenUser');
    
    
    bool isSuccess = false;

    _inProgress = true;

    update();

    Map<String, dynamic> requestBody = {
      "otp": otpNumber,
    }; // Replace your body data

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(Urls.otpVerifyUrl, requestBody,
            accesToken: otpTokenUser); // Replace your api url

    if (response.isSuccess) {
      // Accessing the otpToken from the response data safely
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
