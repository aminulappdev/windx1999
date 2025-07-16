import 'package:get/get.dart';
import 'package:windx1999/app/modules/homepage/model/notification_model.dart';
import 'package:windx1999/app/services/network_caller/network_caller.dart';
import 'package:windx1999/app/services/network_caller/network_response.dart';
import 'package:windx1999/app/services/socket/socket_service.dart';
import 'package:windx1999/app/urls.dart';
import 'package:windx1999/get_storage.dart';

class AllNotificationController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  final SocketService socketService = Get.put(SocketService());
  var isLoading = false.obs;

  var notification = NotificationsModel().obs;
  var notificationList = <NotificationItemModel>[].obs;

  Future<bool> getAllNotification() async {
    bool isSuccess = false;

    isLoading.value = true;

    _inProgress = true;

    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
        Urls.notificationUrl,
        accesToken: StorageUtil.getData(StorageUtil.userAccessToken));

    if (response.isSuccess) {
      notificationList.clear();
      notification.value = NotificationsModel.fromJson(response.responseData);
      notificationList.addAll(notification.value.data ?? []);

      print('📦 Notification loaded from API: ${notificationList.length}');

      // Clear socket notificationList and populate with API messages
      socketService.notificationsList.clear();

      // Api diye data ene notificationList e add kora hoyeche
      for (final ntfy in notificationList) {
        socketService.notificationsList.add({
          "id": ntfy.id.toString(),
          "model_type": ntfy.modelType.toString(),
          "message": ntfy.message.toString(),
          "description": ntfy.description.toString(),
          "read": ntfy.read,
          "isDeleted": ntfy.isDeleted,
          "createdAt": ntfy.createdAt?.toIso8601String() ??
              DateTime.now().toIso8601String(),
        });
      }
      _errorMessage = null;
      isSuccess = true;
      isLoading.value = false;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
