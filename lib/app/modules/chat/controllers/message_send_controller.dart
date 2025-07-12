// import 'package:get/get.dart';
// import 'package:antoinette/services/network_caller/network_caller.dart';
// import 'package:antoinette/services/network_caller/network_response.dart';
// import 'package:antoinette/app/urls.dart';
// import 'package:antoinette/app/utils/get_storage.dart';

// class MessageSendController extends GetxController {
//   bool _inProgress = false;
//   bool get inProgress => _inProgress;

//   String? _errorMessage;
//   String? get errorMessage => _errorMessage;

//   Future<bool> sendMessage(String chatId, String text, String receiverId) async { 
//     _inProgress = true;
//     update();

//     Map<String, dynamic> requestBody = {
//     "chat": chatId,
//     "text": text,
//     "receiver": receiverId
// };

//     final NetworkResponse response = await Get.find<NetworkCaller>()
//         .postRequest(Urls.sendMessageUrl, requestBody,
//             accesToken: box.read('user-login-access-token'));

//     if (response.isSuccess) {
        
//       _errorMessage = null;
//     } else {
//       _errorMessage = response.errorMessage;
//     }

//     _inProgress = false;
//     update();
//     return response.isSuccess;
//   }
// }
