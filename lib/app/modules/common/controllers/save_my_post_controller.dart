import 'package:get/get.dart';
import 'package:windx1999/app/modules/common/model/save_post_model.dart';
import 'package:windx1999/app/services/network_caller/network_caller.dart';
import 'package:windx1999/app/services/network_caller/network_response.dart';
import 'package:windx1999/app/urls.dart';
import 'package:windx1999/get_storage.dart';

class SaveAllPostController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  SavePostModel? savePostModel;
  List<SavePostItemModel>? get savePostData => savePostModel?.data;

  Future<bool> getMySavePost() async {
    bool isSuccess = false;

    _inProgress = true;

    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
        Urls.mySavePostUrl,
        accesToken: StorageUtil.getData(StorageUtil.userAccessToken));

    if (response.isSuccess) {
      savePostModel = SavePostModel.fromJson(response.responseData);
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
