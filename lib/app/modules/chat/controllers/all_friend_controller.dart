import 'package:get/get.dart';
import 'package:windx1999/app/modules/chat/model/all_friends_model.dart';
import 'package:windx1999/app/services/network_caller/network_caller.dart';
import 'package:windx1999/app/services/network_caller/network_response.dart';
import 'package:windx1999/app/services/socket/socket_service.dart';
import 'package:windx1999/app/urls.dart';
import 'package:windx1999/get_storage.dart';

class FriendController extends GetxController {
  final SocketService socketService = Get.put(SocketService());

  // progress states and messages
  bool _inProgress = false;
  bool get inProgress => _inProgress;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // friend related data
  var friends = AllFriendsModel().obs;
  var friendList = <AllFriendsItemModel>[].obs;
  var isLoading = false.obs;

  // initialize friends on controller startup
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

    _inProgress = true;
    isLoading(true);
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
        Urls.allFriendsChatnUrl,
        accesToken: await StorageUtil.getData(StorageUtil.userAccessToken));

    print(
        'response data is get all friends from Controller: ${response.responseData}');

    if (response.isSuccess) {
      friendList.clear();
      friends.value = AllFriendsModel.fromJson(response.responseData);
      print(
          'friends data is get all friends from Controller: ${friends.value.data?.length}');
      friendList.addAll(friends.value.data ?? []);

      socketService.socketFriendtList.clear(); // Clear the socket's friend list

      for (final friend in friendList) {
        print(
            'Socket data added from API: ${friend.chat?.participants[0].name}');
      }

      // Populate socket friend list with API data
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
          "lastMessageTime": friend.message?.createdAt?.toIso8601String() ?? '',
          "isSeen": friend.message?.seen ?? false,
          "unreadCount": friend.unreadMessageCount ?? 0,
          // Add other relevant fields from AllFriendsItemModel as needed
        });
        print('Socket data added from 0 name: ${socketService.socketFriendtList[0]['name']}');
      }

      print('📦 Friends loaded from API: ${friendList.length}');
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    isLoading(false);
    update();
    return isSuccess;
  }
}
