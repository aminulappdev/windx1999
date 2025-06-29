import 'package:get/get.dart';
import 'package:windx1999/app/modules/profile/controllers/profile_controller.dart';
import 'package:windx1999/app/services/network_caller/network_caller.dart';
import 'package:windx1999/app/services/network_caller/network_response.dart';
import 'package:windx1999/app/urls.dart';
import 'package:windx1999/get_storage.dart';

class OrderController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _orderId;
  String? get orderId => _orderId;

  ProfileController profileController = Get.put(ProfileController());

  Future<bool> order({required String packageId}) async {
    await profileController.getMyProfile();
    bool isSuccess = false;

    _inProgress = true;

    update();
    
    print('User id is : ${profileController.profileData?.id}');
    Map<String, dynamic> requestBody = {
      "user": profileController.profileData?.id ?? 'empty id',
      "package": packageId
    };

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(Urls.orderUrl, requestBody,
            accesToken: StorageUtil.getData(StorageUtil.userAccessToken));

    if (response.isSuccess) {
      print(response.responseData);
      _orderId = response.responseData['data']['_id'];   
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
