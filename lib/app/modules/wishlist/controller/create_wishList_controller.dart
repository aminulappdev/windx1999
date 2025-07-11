// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:windx1999/app/urls.dart';
import 'package:windx1999/get_storage.dart';
import 'package:http/http.dart' as http;

class CreateWishListController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _accessToken;
  String? get accessToken => _accessToken;

  /// 🔁 Create Post Function (with optional contentFile)
  Future<bool> createWishList(String authorId, String title, String description,
      String link, dynamic price,
      {PlatformFile? contentFile}) async {
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

      var uri = Uri.parse(Urls.createWishListUrl);
      var request = http.MultipartRequest('POST', uri);

      // ✅ Authorization header
      request.headers['Authorization'] = token;

      // ✅ Set request fields
      Map<String, dynamic> jsonFields = {
        "author": authorId,
        "title": title,
        "description": description,
        "link": link,
        "price": int.parse(price)
      };

      request.fields['data'] = jsonEncode(jsonFields);

      // ✅ Add content file (image or video)
      if (contentFile != null && contentFile.path != null) {
        String filePath = contentFile.path!;
        String? mimeType =
            lookupMimeType(filePath) ?? 'application/octet-stream';

        request.files.add(
          await http.MultipartFile.fromPath(
            'content', // 🔑 Backend expects 'content' as key
            filePath,
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
        _errorMessage = decodedResponse['message'] ?? "Failed to create post";
      }
    } catch (e) {
      _errorMessage = "Error creating post: $e";
    } finally {
      _inProgress = false;
      update();
    }

    return isSuccess;
  }
}
