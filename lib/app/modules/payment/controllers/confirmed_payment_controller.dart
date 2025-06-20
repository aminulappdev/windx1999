import 'package:get/get.dart';
import 'package:windx1999/app/modules/payment/model/confirmed_payment_response_model.dart';
import 'package:windx1999/app/services/network_caller/network_caller.dart';
import 'package:windx1999/app/urls.dart';
import 'package:windx1999/get_storage.dart';

import '../../../services/network_caller/network_response.dart';

class ConfirmedPaymentController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _accessToken;
  String? get accessToken => _accessToken;

  ConfirmedPaymentResponseModel? confirmedPaymentResponseModel;
  ConfirmedPaymentResponseItemModel? get paymentDetails =>
      confirmedPaymentResponseModel?.data;

  Future<bool> confirmPaymentfunction(String id) async {
    bool isSuccess = false;

    _inProgress = true;

    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
        Urls.confirmedPaymentUrlsById(id),
        accesToken: StorageUtil.getData(StorageUtil.userAccessToken));

    if (response.isSuccess) {
      confirmedPaymentResponseModel =
          ConfirmedPaymentResponseModel.fromJson(response.responseData);
      StorageUtil.saveData('payment-reference-id', id);
      print('My data is .............................');
      print(confirmedPaymentResponseModel?.data?.amount);
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
