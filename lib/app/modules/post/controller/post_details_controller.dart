import 'package:get/get.dart';
import 'package:windx1999/app/modules/authentication/controllers/otp_verify_controller.dart';
import 'package:windx1999/app/modules/post/model/post_details_model.dart';
import 'package:windx1999/app/services/network_caller/network_caller.dart';
import 'package:windx1999/app/services/network_caller/network_response.dart';
import 'package:windx1999/app/urls.dart';
import 'package:windx1999/get_storage.dart';

class PostDetailsController extends GetxController {
  final OtpVerifyController otpVerifyController = OtpVerifyController();
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  PostDetailsModel? postDetailsModel;
  PostDetailsData? get postData => postDetailsModel?.data;

  String? _otpToken;
  String? get otpToken => _otpToken;

  Future<bool> getPostDetails(contentId) async {
    bool isSuccess = false;

    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
        Urls.postDetailsById(contentId),
        accesToken: StorageUtil.getData(StorageUtil.userAccessToken));

    if (response.isSuccess) {
      print("Received Data: ${response.responseData}"); // ডিবাগ
      postDetailsModel = PostDetailsModel.fromJson(response.responseData);
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
      print("Error: $_errorMessage");
    }

    _inProgress = false;
    update(); // UI আপডেট নিশ্চিত করা
    return isSuccess;
  }
}
