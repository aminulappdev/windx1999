// // ignore_for_file: avoid_print
// import 'package:get/get.dart';
// import 'package:windx1999/app/modules/authentication/controllers/otp_verify_controller.dart';
// import 'package:windx1999/app/modules/post/model/all_post_model.dart';
// import 'package:windx1999/app/modules/profile/model/profile_details_model.dart';
// import 'package:windx1999/app/services/network_caller/network_caller.dart';
// import 'package:windx1999/app/services/network_caller/network_response.dart';
// import 'package:windx1999/app/urls.dart';
// import 'package:windx1999/get_storage.dart';

// class AllPostController extends GetxController {
//   final OtpVerifyController otpVerifyController = OtpVerifyController();
//   bool _inProgress = false;
//   bool get inProgress => _inProgress;

//   String? _errorMessage;
//   String? get errorMessage => _errorMessage;

//   ProfileDetailsModel? profileDetailsModel;
//   ProfileData? get profileData => profileDetailsModel?.data;

//   AllPostModel? allPostModel;
//   List<AllPostItemModel>? get allPostData => allPostModel?.data;

//   String? _otpToken;
//   String? get otpToken => _otpToken;

//   Future<bool> getAllPost() async {
//     bool isSuccess = false;

//     _inProgress = true;

//     update();

//     final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
//         Urls.allPostUrl,
//         accesToken: StorageUtil.getData(StorageUtil.userAccessToken));

//     if (response.isSuccess) {
//       allPostModel = AllPostModel.fromJson(response.responseData);

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
// ignore_for_file: avoid_print
import 'package:get/get.dart';
import 'package:windx1999/app/modules/authentication/controllers/otp_verify_controller.dart';
import 'package:windx1999/app/modules/post/model/all_post_model.dart';
import 'package:windx1999/app/modules/profile/model/profile_details_model.dart';
import 'package:windx1999/app/services/network_caller/network_caller.dart';
import 'package:windx1999/app/services/network_caller/network_response.dart';
import 'package:windx1999/app/urls.dart';
import 'package:windx1999/get_storage.dart';

class AllPostController extends GetxController {
  final OtpVerifyController otpVerifyController = OtpVerifyController();
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  ProfileDetailsModel? profileDetailsModel;
  ProfileData? get profileData => profileDetailsModel?.data;

  AllPostModel? allPostModel;
  List<AllPostItemModel>? get allPostData => allPostModel?.data;

  String? _otpToken;
  String? get otpToken => _otpToken;

  Future<bool> getAllPost() async {
    bool isSuccess = false;

    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
        Urls.allPostUrl,
        accesToken: StorageUtil.getData(StorageUtil.userAccessToken));

    if (response.isSuccess) {
      allPostModel = AllPostModel.fromJson(response.responseData);
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }

  /// ✅ Call this to update follow status of any post author in UI
  void updateFollowStatus(String userId, bool isFollowingNow) {
    int index = allPostData?.indexWhere((post) => post.author?.id == userId) ?? -1;
    if (index != -1) {
      allPostData![index].isFollowing = isFollowingNow;
      update(); // trigger rebuild
    }
  }
}
