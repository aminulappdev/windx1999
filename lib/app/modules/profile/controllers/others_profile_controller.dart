// ignore_for_file: avoid_print
import 'package:get/get.dart';
import 'package:windx1999/app/modules/authentication/controllers/otp_verify_controller.dart';
import 'package:windx1999/app/modules/profile/model/other_profile_model.dart';
import 'package:windx1999/app/services/network_caller/network_caller.dart';
import 'package:windx1999/app/services/network_caller/network_response.dart';
import 'package:windx1999/app/urls.dart';
import 'package:windx1999/get_storage.dart';

class OthesrProfileController extends GetxController {
  final OtpVerifyController otpVerifyController = OtpVerifyController();
  var _inProgress = false.obs; // Make reactive with .obs
  bool get inProgress => _inProgress.value;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  var otherProfileModel = Rxn<OtherProfileModel>(); // Make reactive with Rxn for nullable
  OtherProfileData? get otherProfileData => otherProfileModel.value?.data;

  String? _otpToken;
  String? get otpToken => _otpToken;

  Future<bool> getOthersProfile(String userId) async {
    _inProgress.value = true;

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
        Urls.otherUserByUrl(userId),
        accesToken: StorageUtil.getData(StorageUtil.userAccessToken));

    bool isSuccess = false;
    if (response.isSuccess) {
      otherProfileModel.value = OtherProfileModel.fromJson(response.responseData);
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress.value = false;
    return isSuccess;
  }

  // New method to update follow status reactively
  void updateFollowStatus(bool isFollowing) {
    if (otherProfileModel.value?.data != null) {
      final updatedData = OtherProfileData(
        id: otherProfileModel.value!.data!.id,
        name: otherProfileModel.value!.data!.name,
        email: otherProfileModel.value!.data!.email,
        username: otherProfileModel.value!.data!.username,
        photoUrl: otherProfileModel.value!.data!.photoUrl,
        banner: otherProfileModel.value!.data!.banner,
        tokenAmount: otherProfileModel.value!.data!.tokenAmount,
        status: otherProfileModel.value!.data!.status,
        isDeleted: otherProfileModel.value!.data!.isDeleted,
        dataId: otherProfileModel.value!.data!.dataId,
        createdAt: otherProfileModel.value!.data!.createdAt,
        updatedAt: otherProfileModel.value!.data!.updatedAt,
        bio: otherProfileModel.value!.data!.bio,
        city: otherProfileModel.value!.data!.city,
        country: otherProfileModel.value!.data!.country,
        state: otherProfileModel.value!.data!.state,
        street: otherProfileModel.value!.data!.street,
        zipCode: otherProfileModel.value!.data!.zipCode,
        profilePublic: otherProfileModel.value!.data!.profilePublic,
        isFollowing: isFollowing, // Update only the isFollowing field
        followers: otherProfileModel.value!.data!.followers,
        following: otherProfileModel.value!.data!.following,
      );
      otherProfileModel.value = OtherProfileModel(
        success: otherProfileModel.value!.success,
        message: otherProfileModel.value!.message,
        data: updatedData,
      );
    }
  }
}