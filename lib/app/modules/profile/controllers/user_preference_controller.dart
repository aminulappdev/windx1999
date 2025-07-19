import 'dart:convert';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:windx1999/app/urls.dart';
import 'package:windx1999/get_storage.dart';
import 'package:http/http.dart' as http;

class UserPreferenceController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _accessToken;
  String? get accessToken => _accessToken;

  /// 🔁 Update Profile Function
  Future<bool> updateProfile(bool profilePublic, bool personalizedAdd) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    try {
      String? token = StorageUtil.getData(StorageUtil.userAccessToken);
      if (token == null || token.isEmpty) {
        _errorMessage = "User not authenticated";
        _inProgress = false;
        update();
        return false;
      }

      var uri = Uri.parse(Urls.userUpdateProfileUrl);
      var request = http.MultipartRequest('PUT', uri);

      // ✅ Only Authorization header
      request.headers['Authorization'] = token;

      // ✅ Set 'data' field with JSON-encoded string
      Map<String, dynamic> jsonFields = {
        "profilePublic": profilePublic,
        "personalizedAds": personalizedAdd
      };

      request.fields['data'] = jsonEncode(jsonFields);

      // ✅ Add image if available

      // 📡 Send request
      var streamedResponse = await request.send();
      var responseBody = await streamedResponse.stream.bytesToString();

      print('📥 Server Response:');
      print(responseBody);

      var decodedResponse = jsonDecode(responseBody);

      if (streamedResponse.statusCode == 200) {
        _errorMessage = null;
        isSuccess = true;
      } else {
        _errorMessage =
            decodedResponse['message'] ?? "Failed to update profile";
      }
    } catch (e) {
      _errorMessage = "Error updating profile: $e";
    } finally {
      _inProgress = false;
      update();
    }

    return isSuccess;
  }
}
