// ignore_for_file: library_prefixes

import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:windx1999/app/modules/profile/controllers/profile_controller.dart';
import 'package:windx1999/app/urls.dart';

import 'package:windx1999/get_storage.dart';

class SocketService extends GetxController {
  late IO.Socket _socket;

  RxBool isLoading = false.obs;
  final ProfileController profileController = Get.put(ProfileController());
//
  // 🟢 RxList রাখা হয়েছে যাতে UI Obx দিয়ে observe করতে পারে
  final _messageList = <Map<String, dynamic>>[].obs;
  final _socketTherapistList = <Map<String, dynamic>>[].obs;

  // 🔁 Updated: এখন RxList return করবে, Obx রিঅ্যাক্ট করবে
  RxList<Map<String, dynamic>> get messageList => _messageList;
  RxList<Map<String, dynamic>> get socketTherapistList => _socketTherapistList;

  String? userIID;

  IO.Socket get sokect => _socket;

  Future<SocketService> init() async {
    final token = StorageUtil.getData(StorageUtil.userAccessToken);
    print('user Id socket theke : ${StorageUtil.getData('user-id')}');
    final userId = StorageUtil.getData('user-id') ??
        'Id ekhono ase nay'; // এখানে আপনি চাইলে profile থেকে নিতে পারেন

    _socket = IO.io(Urls.socketUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
      'extraHeaders': {'token': token},
    });

    _socket.on('connect', (_) {
      print('✅ Connected to the server');
      _socket.emit("connection", userId);
    });

    _socket.onConnect((_) async {
      print('🟢 Socket connected');
      _socket.emit("connection", userId);
    });

    // 🎯 নতুন মেসেজ এলে add করে messageList-এ
    _socket.on('new-message', (data) {
      _handleIncomingMessage(data);
    });

    _socket.on('checking_notification', (data) {
      print('Check in data from socket');
      print(data);
    });

    // 🎯 নতুন friend এলে add করে socketTherapistList-এ
    _socket.on('latest_friend', (data) {
      _handleIncomingFriends(data);
    });

    _socket.onDisconnect((_) {
      print('🔴 Socket disconnected');
    });

    return this;
  }

  void disconnect() {
    _socket.disconnect();
  }

  // 🛠 Incoming Message Handle
  void _handleIncomingMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      final parsedMessage = {
        "id": data["id"]?.toString(),
        "text": data["text"] ?? "",
        "imageUrl": data["imageUrl"] ?? "",
        "seen": data["seen"] ?? false,
        "senderId": data["sender"]?.toString(),
        "receiverId": data["receiver"]?.toString(),
        "chat": data["chat"]?.toString(),
      };

      _messageList.add(parsedMessage);
      print('📩 Message added to list: ${_messageList.length}');
    }
  }

  // 🛠 Incoming Friend Handle
  void _handleIncomingFriends(dynamic data) {
    if (data is Map<String, dynamic> && data.containsKey('receiver')) {
      _socketTherapistList.add(data);
      print('👥 Friend added to list: ${_socketTherapistList.length}');
    }
  }
}
