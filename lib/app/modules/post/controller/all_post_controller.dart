
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

  // AllPostModel? allPostModel;
  // List<AllPostItemModel>? get allPostData => allPostModel?.data;

  List<AllPostItemModel> postList = [];
  List<AllPostItemModel> get allPostList => postList;

  String? _otpToken;
  String? get otpToken => _otpToken;

  final int _limit = 5;
  int page = 0;

  int? lastPage;

  Future<bool> getAllPost() async {
    if (_inProgress) {
      return false;
    }
    page++;

    if (lastPage != null && page > lastPage!) return false;

    bool isSuccess = false;

    _inProgress = true;

    update();

    Map<String, dynamic> queryparam = {'limit': _limit, 'page': page};
    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
        Urls.allPostUrl,
        queryParams: queryparam,
        accesToken: StorageUtil.getData(StorageUtil.userAccessToken));

    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;

      AllPostModel allPostModel = AllPostModel.fromJson(response.responseData);
      postList.addAll(allPostModel.data);

      if (allPostModel.meta?.totalPage != null) {
        lastPage = allPostModel.meta!.totalPage;
      }

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

  void updatePostLike(String postId, bool isLiked, int likeCount) {
    if (postList == null) return;
    int index =
        postList!.indexWhere((post) => post.contentMeta?.id == postId);
    if (index != -1) {
      final post = postList![index];
      postList![index] = AllPostItemModel(
        id: post.id,
        description: post.description,
        content: post.content,
        contentType: post.contentType,
        contentMeta: ContentMeta(
          id: post.contentMeta?.id,
          like: likeCount,
          comment: post.contentMeta?.comment,
          share: post.contentMeta?.share,
          likeBy: [],
        ),
        author: post.author,
        isLiked: isLiked,
        isWatchLater: post.isWatchLater,
        isHide: post.isHide,
        isFollowing: post.isFollowing,
        createdAt: post.createdAt,
        hideBy: [],
      );
      update();
    }
  }

  void updatePostSave(String postId, bool isSaved) {
    if (postList == null) return;
    int index = postList!.indexWhere((post) => post.id == postId);
    if (index != -1) {
      final post = postList![index];
      postList![index] = AllPostItemModel(
        id: post.id,
        description: post.description,
        content: post.content,
        contentType: post.contentType,
        contentMeta: post.contentMeta,
        author: post.author,
        isLiked: post.isLiked,
        isWatchLater: isSaved,
        isHide: post.isHide,
        isFollowing: post.isFollowing,
        createdAt: post.createdAt,
        hideBy: [],
      );
      update();
    }
  }

  void updatePostUnSave(String postId, bool isSaved) {
    if (postList == null) return;
    int index = postList!.indexWhere((post) => post.id == postId);
    if (index != -1) {
      final post = postList![index];
      postList![index] = AllPostItemModel(
        id: post.id,
        description: post.description,
        content: post.content,
        contentType: post.contentType,
        contentMeta: post.contentMeta,
        author: post.author,
        isLiked: post.isLiked,
        isWatchLater: isSaved,
        isHide: post.isHide,
        isFollowing: post.isFollowing,
        createdAt: post.createdAt,
        hideBy: [],
      );
      update();
    }
  }

  void updatePostHide(String postId, bool isHidden) {
    if (postList == null) return;
    int index = postList!.indexWhere((post) => post.id == postId);
    if (index != -1) {
      final post = postList![index];
      postList![index] = AllPostItemModel(
        id: post.id,
        description: post.description,
        content: post.content,
        contentType: post.contentType,
        contentMeta: post.contentMeta,
        author: post.author,
        isLiked: post.isLiked,
        isWatchLater: post.isWatchLater,
        isHide: isHidden,
        isFollowing: post.isFollowing,
        createdAt: post.createdAt,
        hideBy: [],
      );
      update();
    }
  }

  void updateFollowStatus(String userId, bool isFollowingNow) {
    if (postList == null) return;
    int index = postList!.indexWhere((post) => post.author?.id == userId);
    if (index != -1) {
      final post = postList![index];
      postList![index] = AllPostItemModel(
        id: post.id,
        description: post.description,
        content: post.content,
        contentType: post.contentType,
        contentMeta: post.contentMeta,
        author: post.author,
        isLiked: post.isLiked,
        isWatchLater: post.isWatchLater,
        isHide: post.isHide,
        isFollowing: isFollowingNow,
        createdAt: post.createdAt,
        hideBy: [],
      );
      update();
    }
  }
}
