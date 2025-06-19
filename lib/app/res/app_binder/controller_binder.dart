import 'package:get/get.dart';
import 'package:windx1999/app/modules/authentication/controllers/create_user_controller.dart';
import 'package:windx1999/app/modules/authentication/controllers/forgot_email_controller.dart';
import 'package:windx1999/app/modules/authentication/controllers/log_in_controller.dart';
import 'package:windx1999/app/modules/authentication/controllers/otp_verify_controller.dart';
import 'package:windx1999/app/modules/authentication/controllers/resend_otp_controller.dart';
import 'package:windx1999/app/modules/authentication/controllers/reset_password_controller.dart';
import 'package:windx1999/app/modules/common/controllers/theme_controller.dart';
import 'package:windx1999/app/modules/profile/controllers/profile_controller.dart';
import 'package:windx1999/app/modules/profile/controllers/profile_setup_controller.dart';
import 'package:windx1999/app/modules/profile/controllers/setup_address_controller.dart';
import 'package:windx1999/app/modules/token/controllers/all_package_controller.dart';
import 'package:windx1999/app/modules/token/controllers/order_controller.dart';
import 'package:windx1999/app/services/network_caller/network_caller.dart';


class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(ThemeController());
    Get.put(CreateUserController());
    Get.put(NetworkCaller());
    Get.put(OtpVerifyController());
    Get.put(LogInController());
    Get.put(ForgotEmailController());
    Get.put(ResetPasswordController());
    Get.put(ResendOtpController());
    Get.put(SetupAddressController());
    Get.put(SetupProfileController());
    Get.put(AllPackageController());
    Get.put(ProfileController());
    Get.put(OrderController());
   
  }
 
}