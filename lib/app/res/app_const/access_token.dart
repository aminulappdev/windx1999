import 'package:windx1999/get_storage.dart';

class AccessToken {
  // Change const to final
  static String get userAccessToken => box.read('user-access-token');
}