import 'package:get/get.dart';
import 'package:windx1999/app/modules/authentication/controllers/create_user_controller.dart';
import 'package:windx1999/app/modules/authentication/controllers/otp_verify_controller.dart';
import 'package:windx1999/app/modules/common/controllers/theme_controller.dart';
import 'package:windx1999/app/services/network_caller/network_caller.dart';


class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(ThemeController());
    Get.put(CreateUserController());
    Get.put(NetworkCaller());
    Get.put(OtpVerifyController());
   
  }
 
}