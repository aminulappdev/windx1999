// import 'package:get/get.dart';
// import 'package:windx1999/app/modules/authentication/controllers/otp_verify_controller.dart';
// import 'package:windx1999/app/services/network_caller/network_caller.dart';
// import 'package:windx1999/app/services/network_caller/network_response.dart';
// import 'package:windx1999/app/urls.dart';
// import 'package:windx1999/get_storage.dart';

// class SendCommentController extends GetxController {
//   final OtpVerifyController otpVerifyController = OtpVerifyController();
//   bool _inProgress = false;
//   bool get inProgress => _inProgress;

//   String? _errorMessage;
//   String? get errorMessage => _errorMessage;

//   String? _otpToken;
//   String? get otpToken => _otpToken;

//   Future<bool> sendComment(String userId, String modelType, String contentId,
//       String comment, bool isReply, String? repReference) async {
//     bool isSuccess = false;

//     _inProgress = true;
//     update();
//     Map<String, dynamic> requestBody;

//     print('reply reference : $repReference');
//     if (repReference == '' || repReference == null) {
//       requestBody = {
//         "user": userId,
//         "modelType": modelType, // here modelType is: Wishlist | Feed | Reels
//         "content": contentId, // post id
//         "comment": comment,
//         "isReply": isReply
//       };
//     } else {
//       requestBody = {
//         "user": userId,
//         "modelType": modelType, // here modelType is: Wishlist | Feed | Reels
//         "content": contentId, // post id
//         "comment": comment,
//         "isReply": isReply,
//         "replyRef" : repReference
//       };
//     }

//     final NetworkResponse response = await Get.find<NetworkCaller>()
//         .postRequest(Urls.sendCommentUrl, requestBody,
//             accesToken: StorageUtil.getData(StorageUtil.userAccessToken));

//     if (response.isSuccess) {
//       _errorMessage = null;
//       isSuccess = true;
//     } else {
//       _errorMessage = response.errorMessage;
//     }

//     _inProgress = false;
//     update();
//     return isSuccess;
//   }
// }

import 'package:get/get.dart';
import 'package:windx1999/app/modules/authentication/controllers/otp_verify_controller.dart';
import 'package:windx1999/app/services/network_caller/network_caller.dart';
import 'package:windx1999/app/services/network_caller/network_response.dart';
import 'package:windx1999/app/urls.dart';
import 'package:windx1999/get_storage.dart';

class SendCommentController extends GetxController {
  final OtpVerifyController otpVerifyController = OtpVerifyController();
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _otpToken;
  String? get otpToken => _otpToken;

  Future<bool> sendComment(String userId, String modelType, String contentId,
      String comment, bool isReply, String? replyRef) async {
    bool isSuccess = false;

    _inProgress = true;
    update();
    Map<String, dynamic> requestBody;

    print('reply reference : $replyRef');
    if (replyRef == null || replyRef.isEmpty) {
      requestBody = {
        "user": userId,
        "modelType": modelType, // here modelType is: Wishlist | Feed | Reels
        "content": contentId, // post id
        "comment": comment,
        "isReply": isReply
      };
    } else {
      requestBody = {
        "user": userId,
        "modelType": modelType, // here modelType is: Wishlist | Feed | Reels
        "content": contentId, // post id
        "comment": comment,
        "isReply": isReply,
        "replyRef": replyRef
      };
    }

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(Urls.sendCommentUrl, requestBody,
            accesToken: StorageUtil.getData(StorageUtil.userAccessToken));

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
