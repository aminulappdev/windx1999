import 'package:get/get.dart';
import 'package:windx1999/app/modules/payment/views/payment_success_screen.dart';
import 'package:windx1999/app/services/network_caller/network_caller.dart';
import 'package:windx1999/app/services/network_caller/network_response.dart';

class PaymentURLController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _accessToken;
  String? get accessToken => _accessToken;

  Future<bool> paymentUrl(String paymentLink) async {
    bool isSuccess = false;

    _inProgress = true;

    update();

    final NetworkResponse response =
        await Get.find<NetworkCaller>().getRequest(paymentLink);

    if (response.isSuccess) {
      //  Navigator.pushNamed(context, PaymentSuccessScreen.routeName);
      print('Payment Controller theke done');
      Get.to(PaymentSuccessScreen());

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
