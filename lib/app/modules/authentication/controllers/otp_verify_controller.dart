// ignore_for_file: avoid_print
import 'package:get/get.dart';
import 'package:windx1999/app/modules/authentication/model/otp_response_mode.dart';
import 'package:windx1999/app/services/network_caller/network_caller.dart';
import 'package:windx1999/app/services/network_caller/network_response.dart';
import 'package:windx1999/app/urls.dart';
import 'package:windx1999/get_storage.dart';

class OtpVerifyController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _otpToken;
  String? get otpToken => _otpToken;

  OtpResponseModel? otpResponseModel;
  OtpData? get otpData => otpResponseModel?.data;

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
        .postRequestWithToken(Urls.otpVerifyUrl, requestBody,
            accesToken: otpTokenUser); // Replace your api url

    if (response.isSuccess) {
      // Accessing the otpToken from the response data safely

      otpResponseModel = OtpResponseModel.fromJson(response.responseData);
      print('Otp response model : ${response.responseData}');
      print('Token is : ${response.responseData['data']['token']}');
      var token = response.responseData['data']['token'];
      StorageUtil.saveData('user-access-token', token);

      print(
          'Local Token is : ${StorageUtil.getData(StorageUtil.userAccessToken)}');
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
