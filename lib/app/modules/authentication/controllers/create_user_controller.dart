// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:windx1999/app/modules/authentication/controllers/otp_verify_controller.dart';
import 'package:windx1999/app/modules/authentication/model/create_user_model.dart';
import 'package:windx1999/app/services/network_caller/network_caller.dart';
import 'package:windx1999/app/services/network_caller/network_response.dart';
import 'package:windx1999/app/urls.dart';

class CreateUserController extends GetxController {
  final OtpVerifyController otpVerifyController = OtpVerifyController();
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  CreateUserModel? createUserModel;
  CreateUserItemModel? get userData => createUserModel?.data;

  String? _otpToken;
  String? get otpToken => _otpToken;

  Future<bool> createUser(String fname, String lName, String email,
      String password, String cPassword) async {
    bool isSuccess = false;

    _inProgress = true;

    update();

    Map<String, dynamic> requestBody = {
      "firstName": fname,
      "lastName": lName,
      "email": email,
      "password": password,
    }; // Replace your body data

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(Urls.createUserUrl, requestBody); // Replace your api url

    if (response.isSuccess) {
      // Accessing the otpToken from the response data safely
      createUserModel = CreateUserModel.fromJson(requestBody);


      print('Controller data is done.........');
      print(response.responseData);

      if (response.responseData != null &&
          response.responseData['data'] != null &&
          response.responseData['data']['otpToken'] != null &&
          response.responseData['data']['otpToken']['token'] != null) {
        print(
            "OTP Token: ${response.responseData['data']['otpToken']['token']}");

        otpVerifyController.otpToken = response.responseData['data']['otpToken']['token'];
        print('Controller otp token = ${otpVerifyController.otpToken}');
        _otpToken = response.responseData['data']['otpToken']['token'];
        print('OTP Data : $_otpToken');
  

      } else {
        print("OTP Token is null");
      }

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
