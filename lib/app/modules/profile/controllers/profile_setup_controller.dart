import 'dart:convert';
import 'dart:io';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:windx1999/app/urls.dart';
import 'package:windx1999/get_storage.dart';
import 'package:http/http.dart' as http;

class SetupProfileController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _accessToken;
  String? get accessToken => _accessToken;

  /// 🔁 Update Profile Function
  Future<bool> updateProfile(String name, String username, String bio,
      String gender, File? image) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    try {
      String? token = box.read('user-access-token');
      if (token == null || token.isEmpty) {
        _errorMessage = "User not authenticated";
        _inProgress = false;
        update();
        return false;
      }

      var uri = Uri.parse(Urls.userUpdateProfileUrl);
      var request = http.MultipartRequest('PATCH', uri);

      // ✅ Only Authorization header
      request.headers['Authorization'] = 'Bearer $token';

      // ✅ Set 'data' field with JSON-encoded stringr
      Map<String, dynamic> jsonFields = {
        "name": name,
        "username": username,
        "gender": gender,
        "bio": bio,
      };

      request.fields['data'] = jsonEncode(jsonFields);

      // ✅ Add image if available
      if (image != null) {
        print('Image ache ekhane ................................');
        print(image);
        String imagePath = image.path;
        String? mimeType = lookupMimeType(imagePath) ?? 'image/jpeg';

        request.files.add(
          await http.MultipartFile.fromPath(
            'image', // 🔑 Backend should expect this key
            imagePath,
            contentType: MediaType.parse(mimeType),
          ),
        );
      }

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
