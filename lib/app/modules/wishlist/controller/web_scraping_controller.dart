import 'package:get/get.dart';
import 'package:windx1999/app/modules/authentication/controllers/otp_verify_controller.dart';
import 'package:windx1999/app/modules/wishlist/model/scraping_response_model.dart';
import 'package:windx1999/app/modules/wishlist/model/wishlist_details_model.dart';
import 'package:windx1999/app/services/network_caller/network_caller.dart';
import 'package:windx1999/app/services/network_caller/network_response.dart';
import 'package:windx1999/app/urls.dart';
import 'package:windx1999/get_storage.dart';

class WebScrappingController extends GetxController {
  final OtpVerifyController otpVerifyController = OtpVerifyController();
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;


  SrapingResponseModel? srapingResponseModel;
  ScrapingData? get scrapingData => srapingResponseModel?.data;

  String? _otpToken;
  String? get otpToken => _otpToken;

  Future<bool> sraping(String link, String type) async {
    bool isSuccess = false;

    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().postRequest(
      Urls.scrapingUrl,
      {
        "link": link,
        // "platform": type, // amazon | emag | jumia
      },
      accesToken: StorageUtil.getData(StorageUtil.userAccessToken),
    );

    if (response.isSuccess) {
      srapingResponseModel = SrapingResponseModel.fromJson(response.responseData);
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage ?? 'Failed to scrape data';
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}