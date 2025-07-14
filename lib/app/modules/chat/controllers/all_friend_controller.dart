
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
  var friends = AllFriendsModel(success: false, message: "", data: []).obs;
  var friendList = <AllFriendsItemModel>[].obs;

  

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

    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
        Urls.allFriendsChatnUrl,
        accesToken: StorageUtil.getData(StorageUtil.userAccessToken));

    print('response data is : ${response.responseData}');

    if (response.isSuccess) {
      friendList.clear();
      friends.value = AllFriendsModel.fromJson(response.responseData);
      friendList.addAll(friends.value.data);

      socketService.socketTherapistList.clear(); // Clear the socket's friend list

      if (friendList.isNotEmpty) {
        for (var i = 0; i < friendList.length; i++) {
          var chat = friendList[i].chat;
          if (chat != null && chat.participants.isNotEmpty) {
            socketService.socketTherapistList.add({
              "id": chat.id ?? 'No ID',
              "name": chat.participants[0].name ?? 'No Name',
              "email": chat.participants[0].email ?? 'No Email',          
              "image": chat.participants[0].photoUrl ?? 'No Image',
              "lastMessage": friendList[i].message?.text ?? 'No Message',
            });
          } else {
            print("Participants list is empty or chat is null for friend $i");
          }
        }
      }

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
