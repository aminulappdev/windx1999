import 'package:get/get.dart';
import 'package:windx1999/app/modules/authentication/controllers/otp_verify_controller.dart';
import 'package:windx1999/app/modules/profile/model/all_feed_model.dart';
import 'package:windx1999/app/services/network_caller/network_caller.dart';
import 'package:windx1999/app/services/network_caller/network_response.dart';
import 'package:windx1999/app/urls.dart';
import 'package:windx1999/get_storage.dart';

class AllFeedController extends GetxController {
  final OtpVerifyController otpVerifyController = OtpVerifyController();
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  AllFeedModel? allFeedItemModel;
  List<AllFeedItemModel>? get allFeedData => allFeedItemModel?.data;

  String? _otpToken;
  String? get otpToken => _otpToken;

  Future<bool> getAllFeed(String userId) async {
    bool isSuccess = false;

    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
        Urls.allFeedById(userId),
        accesToken: StorageUtil.getData(StorageUtil.userAccessToken));

    if (response.isSuccess) {
      allFeedItemModel = AllFeedModel.fromJson(response.responseData);
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
