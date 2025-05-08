import 'package:get/get.dart';
import 'package:windx1999/app/services/network_caller/network_caller.dart';
import 'package:windx1999/app/services/network_caller/network_response.dart';
import 'package:windx1999/app/urls.dart';

class PostController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> profileSetup(
      String name, String username, String bio, String gender) async {
    bool isSuccess = false;

    _inProgress = true;

    update();

    Map<String, dynamic> requestBody = {
      "name": name,
      "firstName": username,
      "gender": gender,
      "bio": bio,
    }; // Rplace your body data

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .patchRequest(Urls.createUserUrl,
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
