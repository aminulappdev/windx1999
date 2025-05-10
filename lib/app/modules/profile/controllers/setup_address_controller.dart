import 'package:get/get.dart';
import 'package:windx1999/app/services/network_caller/network_caller.dart';
import 'package:windx1999/app/services/network_caller/network_response.dart';
import 'package:windx1999/app/urls.dart';
import 'package:windx1999/get_storage.dart';

class SetupAddressController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> updateAddress(String userId, String country, String address,
      String city, String state, String zipCode) async {
    bool isSuccess = false;

    _inProgress = true;

    update();

    print(
        'SetupAddressController er moddhe Data : $country $address $country $state $zipCode');

    Map<String, dynamic> requestBody = {
      "country": country,
      "state": state,
      "city": city,
      "zipCode": zipCode,
      "street": address
    }; // Rplace your body data

    print(
        'SetupAddressController er moddhe access token : ${box.read('user-access-token')}');
    final NetworkResponse response = await Get.find<NetworkCaller>()
        .patchRequest(Urls.userUpdateProfileUrl,
            accesToken: box.read('user-access-token'),
            body: requestBody); // Replace your api url

    if (response.isSuccess) {
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
