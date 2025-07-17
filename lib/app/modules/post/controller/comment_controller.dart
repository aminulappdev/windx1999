import 'package:get/get.dart';
import 'package:windx1999/app/modules/authentication/controllers/otp_verify_controller.dart';
import 'package:windx1999/app/modules/post/model/comment_model.dart';
import 'package:windx1999/app/services/network_caller/network_caller.dart';
import 'package:windx1999/app/services/network_caller/network_response.dart';
import 'package:windx1999/app/urls.dart';
import 'package:windx1999/get_storage.dart';

class CommentController extends GetxController {
  final OtpVerifyController otpVerifyController = OtpVerifyController();
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  CommentModel? commentModel;
  List<CommentItemModel>? get commentData => commentModel?.data;

  String? _otpToken;
  String? get otpToken => _otpToken;

  Future<bool> getAllComment(contentId) async {
    bool isSuccess = false;

    _inProgress = true;
    update();
    Map<String, dynamic> params = {'limit': 200, 'page': 1};
    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
        Urls.commentByContentId(contentId),
        queryParams: params,
        accesToken: StorageUtil.getData(StorageUtil.userAccessToken));

    if (response.isSuccess) {
      commentModel = CommentModel.fromJson(response.responseData);
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
