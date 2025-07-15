import 'package:get/get.dart';
import 'package:windx1999/app/services/network_caller/network_caller.dart';
import 'package:windx1999/app/services/network_caller/network_response.dart';
import 'package:windx1999/app/urls.dart';
import 'package:windx1999/get_storage.dart';

class MessageSendController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> sendMessage(
      String chatId, String text, String receiverId) async {
    _inProgress = true;
    update();

    Map<String, dynamic> requestBody = {
      "chat": chatId,
      "text": text,
      "receiver": receiverId, // reciver id
    };

    
    
    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(Urls.sendMessageUrl, requestBody,
            accesToken: StorageUtil.getData(StorageUtil.userAccessToken));

    if (response.isSuccess) {
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return response.isSuccess;
  }
}
