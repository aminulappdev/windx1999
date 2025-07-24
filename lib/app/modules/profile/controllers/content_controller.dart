import 'package:get/get.dart';
import 'package:windx1999/app/modules/profile/model/content_model.dart';
import 'package:windx1999/app/services/network_caller/network_caller.dart';
import 'package:windx1999/app/services/network_caller/network_response.dart';
import 'package:windx1999/app/urls.dart';
import 'package:windx1999/get_storage.dart';

class ContentController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  bool get initialInProgress => page == 1;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _accessToken;
  String? get accessToken => _accessToken;

  ContentModel? _contentModel;
  List<ContentItemModel>? get contentlist => _contentModel?.data;

  int page = 0;

  int? lastPage;

  Future<bool> getContent() async {
    bool isSuccess = false;
    _inProgress = true;

    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
        Urls.contentUrl,
        accesToken: StorageUtil.getData(StorageUtil.userAccessToken));

    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;

      _contentModel = ContentModel.fromJson(response.responseData);
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
