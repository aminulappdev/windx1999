import 'dart:io';

import 'package:get/get.dart';
import 'package:windx1999/app/services/network_caller/network_caller.dart';
import 'package:windx1999/app/services/network_caller/network_response.dart';
import 'package:windx1999/app/urls.dart';
import 'package:windx1999/get_storage.dart';

// Post controller .............................................................
// .............................................................................

class PostController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> postFunction() async {
    bool isSuccess = false;

    _inProgress = true;

    update();

    Map<String, dynamic> requestBody = {}; // Rplace your body data

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(Urls.createUserUrl, requestBody); // Replace your api url

    if (response.isSuccess) {
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

// Get controller .............................................................
// ............................................................................

class GetController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // ProfileModel? profileModel;
  // ProfileData? get profileData => profileModel?.data;

  Future<bool> getProfileData() async {
    bool isSuccess = false;

    _inProgress = true;

    update();

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest(Urls.createUserUrl, // Replace api url
            accesToken: box.read('user-login-access-token'));

    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;

      // profileModel = ProfileModel.fromJson(response.responseData);
      // print('Controller data..................................');
      // print(profileModel?.data?.email);
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}

// Get controller with pegination .............................................
// ............................................................................

class GetControllerWithPegination extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  bool get initialInProgress => page == 1;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // List<AllSessionItemModel> sessionsList = [];
  // List<AllSessionItemModel> get allProductList => sessionsList;

  final int _limit = 10;
  int page = 0;

  int? lastPage;

  Future<bool> getDataList() async {
    if (_inProgress) {
      return false;
    }
    page++;

    if (lastPage != null && page > lastPage!) return false;
    bool isSuccess = false;
    _inProgress = true;

    update();

    Map<String, dynamic> queryparam = {'limit': _limit, 'page': page};

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest(Urls.createUserUrl, // replace your api url
            queryParams: queryparam,
            accesToken: box.read('user-login-access-token'));

    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;

      // AllSessionModel allSessionModel =
      //     AllSessionModel.fromJson(response.responseData);
      // sessionsList.addAll(allSessionModel.data ?? []);

      // if (allSessionModel.meta?.totalPage != null) {
      //   lastPage = allSessionModel.meta!.totalPage;
      // }
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}

// Post controller with Form data .............................................
// ............................................................................

/*

class PostControllerWithFormData extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _accessToken;
  String? get accessToken => _accessToken;

  String? addressFiled;


  /// 🔁 Update Profile Function
  Future<bool> updateProfile() async {
  
    bool isSuccess = false;
    _inProgress = true;
    update();

    try {
      String? token = box.read('user-login-access-token');
      if (token == null || token.isEmpty) {
        _errorMessage = "User not authenticated";
        _inProgress = false;
        update();
        return false;
      }

      var uri = Uri.parse(Urls.updateProfileUrl);
      var request = http.MultipartRequest('PUT', uri);

      // ✅ Only Authorization header
      request.headers['Authorization'] = token;

      // ✅ Set 'data' field with JSON-encoded string
      Map<String, dynamic> jsonFields = {
        "name": isNameUpdate == true ? name : profileController.profileData?.name ?? name,
        "contractNo": number,
      };

      if (address != null && address.isNotEmpty) {
        if(addressIndex == 'Home'){
              jsonFields['homeAddress'] = address;
        }
        else if(addressIndex == 'Office'){
           jsonFields['officeAddress'] = address;
        }
        else if(addressIndex == 'Delivery'){
           jsonFields['deliveryAddress'] = address;
        }
       
      }
      

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
        _errorMessage = decodedResponse['message'] ?? "Failed to update profile";
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

*/

// Scroll controller ..........................................................
// ............................................................................

/*

final ScrollController scrollController = ScrollController();


  @override
  void initState() {
    scrollController.addListener(_loadMoreData);
    super.initState();
  }

  void _loadMoreData() {
    if (scrollController.position.extentAfter < 500 &&
        !allSessionController.inProgress) {
      allSessionController.getSessionList();
    }
    {
      allSessionController.getSessionList();
    }
  }

*/

// Post Function .............................................................
// ............................................................................

/*

Future<void> onTapToNextButton() async {
    
      final bool isSuccess = await signInController.signIn(emailCtrl.text, passwordCtrl.text, isChecked);

      if (isSuccess) {
        if (mounted) {
          showSnackBarMessage(context, 'Login successfully done');
          Get.to(LogInScreen());
        }
      } else {
        if (mounted) {
          showSnackBarMessage(context, signInController.errorMessage ?? 'Login failed', true);
        }
      }
    
  }

*/
