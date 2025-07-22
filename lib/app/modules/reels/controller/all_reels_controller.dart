import 'package:get/get.dart';
import 'package:windx1999/app/modules/reels/model/all_reels_model.dart';
import 'package:windx1999/app/services/network_caller/network_caller.dart';
import 'package:windx1999/app/services/network_caller/network_response.dart';
import 'package:windx1999/app/urls.dart';
import 'package:windx1999/get_storage.dart';

class AllReelsController extends GetxController {
  var _inProgress = false.obs; // Reactive
  bool get inProgress => _inProgress.value;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  var allReelsModel = Rxn<AllReelsModel>(); // Reactive with Rxn for nullable
  List<AllReelsItemModel>? get allReelsData => allReelsModel.value?.data;

  // Map to track follow status for each author (since Author model lacks isFollowing)
  var followStatus = <String, bool>{}.obs; // Key: author ID, Value: isFollowing

  Future<bool> getAllReels() async {
    _inProgress.value = true;

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
        Urls.allReelsUrl,
        accesToken: StorageUtil.getData(StorageUtil.userAccessToken));

    bool isSuccess = false;
    if (response.isSuccess) {
      allReelsModel.value = AllReelsModel.fromJson(response.responseData);
      // Initialize followStatus map (assuming API doesn't provide isFollowing)
      for (var reel in allReelsModel.value?.data ?? []) {
        if (reel.author?.id != null) {
          followStatus[reel.author!.id!] = followStatus[reel.author!.id] ?? false;
        }
      }
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress.value = false;
    return isSuccess;
  }

  // Method to update follow status for a specific reel's author
  void updateFollowStatus(String authorId, bool isFollowing) {
    followStatus[authorId] = isFollowing;
  }
}