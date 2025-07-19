import 'package:get/get.dart';
import 'package:windx1999/app/modules/chat/model/all_friends_model.dart';
import 'package:windx1999/app/services/network_caller/network_caller.dart';
import 'package:windx1999/app/services/network_caller/network_response.dart';
import 'package:windx1999/app/services/socket/socket_service.dart';
import 'package:windx1999/app/urls.dart';
import 'package:windx1999/get_storage.dart';

class FriendController extends GetxController {
  final SocketService socketService = Get.put(SocketService());

  // ✅ Fixed: Make inProgress reactive
  var inProgress = false.obs;
  var friends = AllFriendsModel().obs;
  var friendList = <AllFriendsItemModel>[].obs;
  var isLoading = false.obs;
  String? errorMessage;

  @override
  void onInit() {
    super.onInit();
    getAllFriends();
  }

  @override
  void onReady() {
    super.onReady();
    getAllFriends();
  }

  Future<bool> getAllFriends() async {
    bool isSuccess = false;

    inProgress.value = true;
    isLoading(true);

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      Urls.allFriendsChatnUrl,
      accesToken: await StorageUtil.getData(StorageUtil.userAccessToken),
    );

    print('response data: ${response.responseData}');

    if (response.isSuccess) {
      friendList.clear();
      friends.value = AllFriendsModel.fromJson(response.responseData);
      friendList.addAll(friends.value.data ?? []);
      socketService.socketFriendtList.clear();

      for (final friend in friendList) {
        socketService.socketFriendtList.add({
          "id": friend.chat?.id.toString() ?? '',
          "receiverId": friend.chat?.participants[0].id.toString() ?? '',
          "name": friend.chat?.participants[0].name ?? '',
          "email": friend.chat?.participants[0].email ?? '',
          "profileImage": friend.chat?.participants[0].photoUrl ?? '',
          "createdAt": friend.chat?.createdAt?.toIso8601String() ??
              DateTime.now().toIso8601String(),
          "lastMessage": friend.message?.text ?? '',
          "lastMessageTime":
              friend.message?.createdAt?.toIso8601String() ?? '',
          "isSeen": friend.message?.seen ?? false,
          "unreadMessageCount": friend.unreadMessageCount ?? 0,
        });
      }

      errorMessage = null;
      isSuccess = true;
    } else {
      errorMessage = response.errorMessage;
    }

    inProgress.value = false;
    isLoading(false);
    return isSuccess;
  }
}
