// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:windx1999/app/modules/authentication/controllers/otp_verify_controller.dart';
import 'package:windx1999/app/modules/authentication/model/create_user_model.dart';
import 'package:windx1999/app/services/network_caller/network_caller.dart';
import 'package:windx1999/app/services/network_caller/network_response.dart';
import 'package:windx1999/app/urls.dart';
import 'package:windx1999/get_storage.dart';

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

  Future<bool> createUser(
      String name, String email, String password, String cPassword) async {
    bool isSuccess = false;

    _inProgress = true;
    update();

    Map<String, dynamic> requestBody = {
      "name": name,
      "email": email,
      "password": password,
    }; // Replace your body data

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(Urls.createUserUrl, requestBody);

    if (response.isSuccess) {
      createUserModel = CreateUserModel.fromJson(response.responseData);

      _otpToken = createUserModel?.data?.otpToken?.token;
      StorageUtil.saveData('user-otp-token',createUserModel?.data?.otpToken?.token);
      print('User Otp token is : ${StorageUtil.getData('user-otp-token')}');

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
