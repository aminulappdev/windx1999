// ignore_for_file: avoid_print
import 'package:get/get.dart';
import 'package:windx1999/app/modules/authentication/controllers/otp_verify_controller.dart';
import 'package:windx1999/app/modules/common/model/all_blockers_model.dart';
import 'package:windx1999/app/services/network_caller/network_caller.dart';
import 'package:windx1999/app/services/network_caller/network_response.dart';
import 'package:windx1999/app/urls.dart';
import 'package:windx1999/get_storage.dart';

class AllBlockersController extends GetxController {
  final OtpVerifyController otpVerifyController = OtpVerifyController();
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  AllBlockersModel? allBlockersModel;
  List<AllBolckersItemModel>? get allBlockersData => allBlockersModel?.data;

  Future<bool> getAllBlockers() async {
    bool isSuccess = false;

    _inProgress = true;

    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
        Urls.allBlockersUrl,
        accesToken: StorageUtil.getData(StorageUtil.userAccessToken));

    if (response.isSuccess) {
      allBlockersModel = AllBlockersModel.fromJson(response.responseData);
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
