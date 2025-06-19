// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:windx1999/app/modules/authentication/controllers/otp_verify_controller.dart';
import 'package:windx1999/app/modules/authentication/model/login_model.dart';
import 'package:windx1999/app/res/app_const/access_token.dart';
import 'package:windx1999/app/services/network_caller/network_caller.dart';
import 'package:windx1999/app/services/network_caller/network_response.dart';
import 'package:windx1999/app/urls.dart';
import 'package:windx1999/get_storage.dart';

class LogInController extends GetxController {
  final OtpVerifyController otpVerifyController = OtpVerifyController();
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  LoginResponseModel? loginResponseModel;
  LoginResponseItemModel? get loginData => loginResponseModel?.data;

  String? _otpToken;
  String? get otpToken => _otpToken;

  Future<bool> loginUser(String email, String password) async {
    bool isSuccess = false;

    _inProgress = true;

    update();

    Map<String, dynamic> requestBody = {
      "email": email,
      "password": password
    }; // Replace your body data

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(Urls.loginUrl, requestBody); // Replace your api url

    if (response.isSuccess) {
      // Accessing the otpToken from the response data safely

      loginResponseModel = LoginResponseModel.fromJson(response.responseData);
      var token = loginData?.accessToken ?? 'No access data';

      StorageUtil.saveData('user-access-token', token);

      print('User id is : ${StorageUtil.getData('user-id')}');
      print('My access token is : $token');

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
