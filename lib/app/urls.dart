class Urls {
  static const String _baseUrl = 'http://172.252.13.74:5010/api/v1';
  // static const String _baseUrl = 'http://192.168.10.144:5010/api/v1';
  static const String socketUrl = 'http://172.252.13.74:4010/';
  // static const String socketUrl = 'http://192.168.10.144:4001/';
  static const String createUserUrl = '$_baseUrl/users/register';
  static const String otpVerifyUrl = '$_baseUrl/otp/verify-otp';
  static const String loginUrl = '$_baseUrl/auth/login';
  static const String forgotEmailUrl = '$_baseUrl/auth/forgot-password';
  static const String resetPasswordUrl = '$_baseUrl/auth/reset-password';
  static const String resendOtpUrl = '$_baseUrl/otp/resend-otp';
  static const String userUpdateProfileUrl = '$_baseUrl/users/update-my-profile';
  static const String allPackageUrl = '$_baseUrl/packages';
  static const String getMyProfleUrl = '$_baseUrl/users/my-profile';
  static const String orderUrl = '$_baseUrl/orders';
  static const String paymentCheckoutUrl = '$_baseUrl/payments/checkout';
  static const String allPostUrl = '$_baseUrl/feeds/public';
  static const String myOrderUrl = '$_baseUrl/orders/my-order';
  static const String allReelsUrl = '$_baseUrl/reels';

  static String updateUserByUrl(
    String id,
  ) {
    return '$_baseUrl/users/update/$id';
  }
   
   static String confirmedPaymentUrlsById(
    String id,
  ) {
    return '$_baseUrl/payments/reference/$id';
  }

}
 