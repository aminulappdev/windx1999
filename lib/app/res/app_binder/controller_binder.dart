import 'package:get/get.dart';
import 'package:windx1999/app/modules/common/controllers/theme_controller.dart';


class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(ThemeController());
   
  }
 
}